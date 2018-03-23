/**
 * SecondaryWeapons_events_hud_onKeyUp
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
 
private["_keyCode", "_dialog"];

_keyCode = _this select 1;
if (_keyCode in (actionKeys "User16")) exitWith
{
	_dialog = uiNameSpace getVariable ["RscDisplayInventory", displayNull];

	if (secondaryWeapon player != "") then
	{
		if (((secondaryWeapon player) splitString "_") select ((count ((secondaryWeapon player) splitString "_"))-1) == "secondary") then 
		{
			if(!(SecondaryWeaponsSwapping) && (_dialog isEqualTo displayNull)) then
			{
				(primaryWeapon player) spawn SecondaryWeapons_events_swapSecondaryWeapon;
			};
		} else {
			if (secondaryWeapon player != currentWeapon player) then
			{
				player selectWeapon (secondaryWeapon player);
			};
		};
	} else {
		if (primaryWeapon player != "") then 
		{
			if(!(SecondaryWeaponsSwapping) && (_dialog isEqualTo displayNull)) then
			{
				(primaryWeapon player) call SecondaryWeapons_events_addSecondaryWeapon;
			};
		};
	};
	true
};