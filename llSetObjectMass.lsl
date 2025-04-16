// adjust_root_density_to_hit_target_mass.lsl
//
// Put this script on the root prim of an object.  When an avatar sits on it
// this script will try to adjust the mass of the root prim to make the total
// final mass of the object+avatar an known quantity no matter the avatar's mass.
//
// Note: this will only work of the root prim has more mass than the largest
// avatar expected to sit.
// Written by Leviathan Linden

float DEBUG = FALSE;
float EXPECTED_AVATAR_MASS = 1.6;  // mass of an "average" avatar
float prim_density = 1000.0;
float prim_volume = 1.0;
float obj_mass = 1.0;
float target_mass_with_sitter = 1.0;
float mass_of_other_parts = 1.0;
integer obj_num_prims = 1;
key prim_key;

measure_prim_volume()
{
    // In order to do the adjustment math we need to know the effective volume
    // of the root prim.  Unfortunately this is not exposed in LSL, however we
    // can measure it by adjusting the root prim's density and doing some math.
    list material = llGetPhysicsMaterial();
    prim_density = llList2Float(material, 3);
    obj_mass = llGetObjectMass(llGetKey());
    target_mass_with_sitter = obj_mass + EXPECTED_AVATAR_MASS;

    float test_density = 2.0 * prim_density;
    llSetPhysicsMaterial(DENSITY, 0.0, 0.0, 0.0, test_density);

    // check to make sure our density setting took effect (it can fail if the prim is
    // already near max density).
    material = llGetPhysicsMaterial();
    float actual_test_density = llList2Float(material, 3);
    if (actual_test_density != test_density)
    {
        // density setting failed --> try a lower density instead
        test_density = 0.5 * prim_density;
        llSetPhysicsMaterial(DENSITY, 0.0, 0.0, 0.0, test_density);
    }

    // we can now compute prim_volume
    float test_mass = llGetObjectMass(llGetKey());
    prim_volume = (test_mass - obj_mass) / (test_density - prim_density);
    if (DEBUG)
    {
        llOwnerSay("prim_volume=" + (string)(prim_volume));
    }

    // we also need to know the total mass of the non-root prims of the original object
    mass_of_other_parts = test_mass - (prim_volume * test_density);

    // restore original density
    llSetPhysicsMaterial(DENSITY, 0.0, 0.0, 0.0, prim_density);
}

adjust_prim_density()
{
    llSleep(1.0);
    // When an avatar sits down the formula for mass becomes:
    //
    //     obj_mass = avatar_mass + mass_of_other_parts + prim_density * prim_volume
    //
    // Let obj_mass equal target_mass_with_sitter and solve for density:
    //
    //     prim_density = (target_mass_with_sitter - avatar_mass - mass_of_other_parts) / prim_volume
    //

    // adjust density to achieve target_mass_with_sitter
    float mass = llGetObjectMass(prim_key);
    float avatar_mass = mass - obj_mass;;
    float target_density = (target_mass_with_sitter - (avatar_mass + mass_of_other_parts)) / prim_volume;
    float MIN_DENSITY = 1.0;
    if (target_density < MIN_DENSITY)
    {
        if (DEBUG)
        {
            llOwnerSay("extra_mass is too heavy");
        }
        target_density = MIN_DENSITY;
    }
    llSetPhysicsMaterial(DENSITY, 0.0, 0.0, 0.0, target_density);

    // check to see how well we succeeded
    if (DEBUG)
    {
        llOwnerSay( "original_mass=" + (string)(obj_mass) + " sit_mass=" + (string)(mass) + " avatar_mass=" + (string)(avatar_mass));
        float final_mass = llGetObjectMass(prim_key);
        float mass_error = target_mass_with_sitter - final_mass;
        llOwnerSay("target_mass=" + (string)(target_mass_with_sitter) + ", after density adjustment: mass_error=" + (string)(mass_error));
    }
}

reset_prim_density()
{
    llSetPhysicsMaterial(DENSITY, 0.0, 0.0, 0.0, prim_density);
    list materials = llGetPhysicsMaterial();
    prim_density = llList2Float(materials, 3);
    if (DEBUG)
    {
        float mass = llGetObjectMass(prim_key);
        llOwnerSay("prim_density=" + (string)(prim_density) + " mass=" + (string)(mass));
    }
}

default
{
    state_entry()
    {
        // measure the object's initial properties
        prim_key = llGetKey();
        obj_num_prims = llGetNumberOfPrims();
        obj_mass = llGetObjectMass(prim_key);
        list material = llGetPhysicsMaterial();
        prim_density = llList2Float(material, 3);

        measure_prim_volume();
    }

    changed(integer change)
    {
        if (change & CHANGED_LINK)
        {
            integer num_prims = llGetNumberOfPrims();
            if (num_prims != obj_num_prims)
            {
                if (DEBUG)
                {
                    float mass = llGetObjectMass(prim_key);
                    float extra_mass = mass - obj_mass;
                    llOwnerSay("extra_mass=" + (string)(extra_mass));
                }
                adjust_prim_density();
            }
            else
            {
                reset_prim_density();
            }
        }
    }
}
