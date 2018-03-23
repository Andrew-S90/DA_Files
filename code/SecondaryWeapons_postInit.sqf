/**
 * SecondaryWeapons_postInit
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

if (hasInterface) then
{
	waitUntil {!isNull (findDisplay 46) && (alive player)};
	diag_log "SecondaryWeapons_postInit";
	SecondaryWeaponsSwapping = false;
	SecondaryWeaponsClassName = "";
	SecondaryWeaponsWeaponInfo = [];
	SecondaryWeaponsTakeFix = [[],[]];
	SecondaryWeaponsSwapSecond = -1;
	SecondaryWeaponsSwapPrimary = -1;
	SecondaryWeaponsAddSecondary = -1;
	SecondaryWeaponsInventoryPosition = [0,0,0,0];
	SecondaryWeaponsAccSlotInfo = [[],626,1249,10050,"\a3\ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_side_gs.paa"]; //position - idc slot - idc background - idc created - img location
	SecondaryWeaponsMagazineSlotInfo = [[],627,1251,10060,"\a3\ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_magazine_gs.paa"];
	SecondaryWeaponsMuzzleSlotInfo = [[],624,1248,10070,"\a3\ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_muzzle_gs.paa"];
	SecondaryWeaponsOpticSlotInfo = [[],625,1250,10080,"\a3\ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_top_gs.paa"];
	SecondaryWeaponsUnderSlotInfo = [[],642,1266,10090,"\a3\ui_f\data\GUI\Rsc\RscDisplayGear\ui_gear_bipod_gs.paa"];
	
	SecondaryWeaponsDropOnDeath = getText(missionConfigFile >> "CfgSecondaryWeapons" >> "DropWeaponOnDeath");
	if((SecondaryWeaponsDropOnDeath isEqualTo "true") || (SecondaryWeaponsDropOnDeath isEqualTo "")) then
	{
		SecondaryWeaponsDropOnDeath = true;
	} else {
		SecondaryWeaponsDropOnDeath = false;
	};
	
	SecondaryWeaponsAddAction = getText(missionConfigFile >> "CfgSecondaryWeapons" >> "UseAddActions");
	if(SecondaryWeaponsAddAction isEqualTo "true") then
	{
		SecondaryWeaponsAddAction = true;
	} else {
		SecondaryWeaponsAddAction = false;
	};
	
	SecondaryWeaponsBlockedWeapons = getArray(missionConfigFile >> "CfgSecondaryWeapons" >> "BlockedWeapons");
	{
		SecondaryWeaponsBlockedWeapons set [_forEachIndex, toLower _x]; 
	} forEach SecondaryWeaponsBlockedWeapons;
	
	[] call SecondaryWeapons_player_hook;
};
true