/**
 * SecondaryWeapons_events_onInventoryClosed
 *
 * Dual Arms Mod
 * Contact: Andrew#0693 on Discord
 * © 2018 Andrew_S90
 *
 * This mod may be used in private repos for units but reuploads on steam/armaholic/playwithsix are not allowed.
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */

InventoryOpened = false;

player setUserActionText [SecondaryWeaponsSwapSecond, format["Weapon %1", getText (configFile >> "CfgWeapons" >> (secondaryWeapon player) >> "displayName")]];
if(SecondaryWeaponsAddAction) then
{
	player setUserActionText [SecondaryWeaponsAddSecondary, format["Put Weapon %1 on back", getText (configFile >> "CfgWeapons" >> (primaryWeapon player) >> "displayName")]];
	player setUserActionText [SecondaryWeaponsSwapPrimary, format["Swap to Weapon %1", getText (configFile >> "CfgWeapons" >> (secondaryWeapon player) >> "displayName")]];
};

if (((secondaryWeapon player) !="") && {((secondaryWeapon player) splitString "_") select ((count ((secondaryWeapon player) splitString "_"))-1) == "secondary"}) then {
	SecondaryWeaponsClassName = (secondaryWeapon player);
} else {
	SecondaryWeaponsClassName = "";
};

true