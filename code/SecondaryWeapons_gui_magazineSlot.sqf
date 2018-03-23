/**
 * SecondaryWeapons_gui_magazineSlot
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

private ["_dialog", "_icoB", "_ico", "_cover", "_pic"];

disableSerialization;

_dialog = uiNameSpace getVariable ["RscDisplayInventory", displayNull];

if !(_this isEqualTo "destroy") then 
{		
	_icoB = _dialog displayCtrl ((SecondaryWeaponsMagazineSlotInfo select 1)*4);
	if!(isNull _icoB) then 
	{
		ctrlDelete _icoB;
	};
	
	_ico = _dialog displayCtrl ((SecondaryWeaponsMagazineSlotInfo select 2)*4);
	if!(isNull _ico) then 
	{
		ctrlDelete _ico;
	};
	
	_cover = _dialog ctrlCreate ["RscText", (SecondaryWeaponsMagazineSlotInfo select 3)];

	_cover ctrlSetPosition (SecondaryWeaponsMagazineSlotInfo select 0);
	_cover ctrlSetBackgroundColor [0.7,0.7,0.7,0.1];
	_cover ctrlCommit 0;
		   
	_pic = _dialog ctrlCreate ["RscPictureKeepAspect", ((SecondaryWeaponsMagazineSlotInfo select 3)+1)];

	_pic ctrlSetPosition (SecondaryWeaponsMagazineSlotInfo select 0);
	_pic ctrlSetText (getText(configFile >> "cfgMagazines" >> (_this select 0) >> "picture"));
	_pic ctrlCommit 0;
}
else
{
	_cover = _dialog displayCtrl (SecondaryWeaponsMagazineSlotInfo select 3);
	if!(isNull _cover) then 
	{
		ctrlDelete _cover;
	};
	
	_pic = _dialog displayCtrl ((SecondaryWeaponsMagazineSlotInfo select 3)+1);
	if!(isNull _pic) then 
	{
		ctrlDelete _pic;
	};
	
	_icoB = _dialog displayCtrl ((SecondaryWeaponsMagazineSlotInfo select 1)*4);
	if!(isNull _icoB) then 
	{
		ctrlDelete _icoB;
	};
	
	_ico = _dialog displayCtrl ((SecondaryWeaponsMagazineSlotInfo select 2)*4);
	if!(isNull _ico) then 
	{
		ctrlDelete _ico;
	};
	
	{
		(_dialog displayCtrl _x) ctrlSetPosition (SecondaryWeaponsMagazineSlotInfo select 0);
		(_dialog displayCtrl _x) ctrlSetScale 1;
		(_dialog displayCtrl _x) ctrlCommit 0;
	} forEach [(SecondaryWeaponsMagazineSlotInfo select 1),(SecondaryWeaponsMagazineSlotInfo select 2)];
	
	SecondaryWeaponsMagazineSlotInfo set [3, 0];
};