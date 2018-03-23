/**
 * SecondaryWeapons_gui_opticSlot
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
	_icoB = _dialog displayCtrl ((SecondaryWeaponsOpticSlotInfo select 1)*4);
	if!(isNull _icoB) then 
	{
		ctrlDelete _icoB;
	};
	
	_ico = _dialog displayCtrl ((SecondaryWeaponsOpticSlotInfo select 2)*4);
	if!(isNull _ico) then 
	{
		ctrlDelete _ico;
	};
	
	_cover = _dialog ctrlCreate ["RscText", (SecondaryWeaponsOpticSlotInfo select 3)];

	_cover ctrlSetPosition (SecondaryWeaponsOpticSlotInfo select 0);
	_cover ctrlSetBackgroundColor [0.7,0.7,0.7,0.1];
	_cover ctrlCommit 0;
		   
	_pic = _dialog ctrlCreate ["RscPictureKeepAspect", ((SecondaryWeaponsOpticSlotInfo select 3)+1)];

	_pic ctrlSetPosition (SecondaryWeaponsOpticSlotInfo select 0);
	_pic ctrlSetText (getText(configFile >> "cfgWeapons" >> _this >> "picture"));
	_pic ctrlCommit 0;
}
else
{
	_cover = _dialog displayCtrl (SecondaryWeaponsOpticSlotInfo select 3);
	if!(isNull _cover) then 
	{
		ctrlDelete _cover;
	};
	
	_pic = _dialog displayCtrl ((SecondaryWeaponsOpticSlotInfo select 3)+1);
	if!(isNull _pic) then 
	{
		ctrlDelete _pic;
	};
	
	_icoB = _dialog displayCtrl ((SecondaryWeaponsOpticSlotInfo select 1)*4);
	if!(isNull _icoB) then 
	{
		ctrlDelete _icoB;
	};
	
	_ico = _dialog displayCtrl ((SecondaryWeaponsOpticSlotInfo select 2)*4);
	if!(isNull _ico) then 
	{
		ctrlDelete _ico;
	};
	
	{
		(_dialog displayCtrl _x) ctrlSetPosition (SecondaryWeaponsOpticSlotInfo select 0);
		(_dialog displayCtrl _x) ctrlSetScale 1;
		(_dialog displayCtrl _x) ctrlCommit 0;
	} forEach [(SecondaryWeaponsOpticSlotInfo select 1),(SecondaryWeaponsOpticSlotInfo select 2)];
	
	SecondaryWeaponsOpticSlotInfo set [3, 0];
};