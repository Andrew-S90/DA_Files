/**
 * SecondaryWeapons_events_onInventoryOpened
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

private ["_throw", "_dialog", "_BG", "_slot", "_prim", "_posSlot", "_posBtn", "_buttonDown", "_buttonUp", "_cover", "_pic", "_icoB", "_ico", "_SecondaryWeaponItems"]; 
 
_throw = false;

try 
{
	if (SecondaryWeaponsSwapping) then 
	{
		throw true;
	};
	
	InventoryOpened = true;
	
	disableSerialization;

	_dialog = uiNameSpace getVariable ["RscDisplayInventory", displayNull];



	_BG = _dialog displayCtrl 1247;
	_slot = _dialog displayCtrl 611;
	_prim = _dialog displayCtrl 610;
	
	SecondaryWeaponsAccSlotInfo set [0, ctrlPosition (_dialog displayCtrl 626)];
	SecondaryWeaponsMagazineSlotInfo set [0, ctrlPosition (_dialog displayCtrl 627)];
	SecondaryWeaponsMuzzleSlotInfo set [0, ctrlPosition (_dialog displayCtrl 624)];
	SecondaryWeaponsOpticSlotInfo set [0, ctrlPosition (_dialog displayCtrl 625)];
	SecondaryWeaponsUnderSlotInfo set [0, ctrlPosition (_dialog displayCtrl 642)];

	_posSlot = ctrlPosition _slot;
	SecondaryWeaponsInventoryPosition = _posSlot;
	_posBtn = ctrlPosition _prim;
	
	_buttonDown = _dialog ctrlCreate ["RscActivePictureDown", 1337];
	_buttonDown ctrlSetPosition [((_posBtn select 0) + (_posBtn select 2) - 0.03), (_posBtn select 1),(_posBtn select 2)/12,(_posBtn select 3)];
	_buttonDown ctrlCommit 0;
	
	_buttonUp = _dialog ctrlCreate ["RscActivePictureUp", 6969];
	_buttonUp ctrlSetPosition [((_posSlot select 0) + (_posSlot select 2) - 0.03), (_posSlot select 1),(_posSlot select 2)/12,(_posSlot select 3)];
	_buttonUp ctrlEnable (SecondaryWeaponsClassName != "");
	_buttonUp ctrlCommit 0;

	if (((secondaryWeapon player) !="") && {((secondaryWeapon player) splitString "_") select ((count ((secondaryWeapon player) splitString "_"))-1) == "secondary"}) then 
	{
		SecondaryWeaponsClassName = (secondaryWeapon player);
		
		_cover = _dialog ctrlCreate ["RscText", 1530];

		_cover ctrlSetPosition _posSlot;
		_cover ctrlSetBackgroundColor [0.7,0.7,0.7,0.1];
		_cover ctrlCommit 0;
			   
		_pic = _dialog ctrlCreate ["RscPictureKeepAspect", 1531];

		_pic ctrlSetPosition _posSlot;
		_pic ctrlSetText (getText(configFile >> "cfgWeapons" >> (secondaryWeapon player) >> "img"));
		_pic ctrlCommit 0;	

		{
			_x ctrlSetPosition [0,0,0,0];
			_x ctrlSetScale 0;
			_x ctrlCommit 0;
		} forEach [_slot,_BG];

		
		{
			(_dialog displayCtrl (_x select 1)) ctrlSetPosition [0,0,0,0];
			(_dialog displayCtrl (_x select 1)) ctrlSetScale 0;
			(_dialog displayCtrl (_x select 1)) ctrlCommit 0;
			
			(_dialog displayCtrl (_x select 2)) ctrlSetPosition [0,0,0,0];
			(_dialog displayCtrl (_x select 2)) ctrlSetScale 0;
			(_dialog displayCtrl (_x select 2)) ctrlCommit 0;
			
			_icoB = _dialog ctrlCreate ["RscText", ((_x select 1)*4)];

			_icoB ctrlSetPosition (_x select 0);
			_icoB ctrlSetBackgroundColor [0.7,0.7,0.7,0.1];
			_icoB ctrlCommit 0;
			
			_ico = _dialog ctrlCreate ["RscPictureKeepAspect", ((_x select 2)*4)];

			_ico ctrlSetPosition (_x select 0);
			_ico ctrlSetText (_x select 4);
			_ico ctrlCommit 0;
			
		} forEach [SecondaryWeaponsAccSlotInfo,SecondaryWeaponsMagazineSlotInfo,SecondaryWeaponsMuzzleSlotInfo,SecondaryWeaponsOpticSlotInfo,SecondaryWeaponsUnderSlotInfo];

		_SecondaryWeaponItems = false call SecondaryWeapons_util_Ammo;
		

		if(((_SecondaryWeaponItems select 0) select 1) != "") then
		{
			((_SecondaryWeaponItems select 0) select 1) call SecondaryWeapons_gui_muzzleSlot;
		};
		
		if(count SecondaryWeaponsWeaponInfo > 0 && !((SecondaryWeaponsWeaponInfo select 0) isEqualTo "ARRAY")) then
		{
			(SecondaryWeaponsWeaponInfo select 0) call SecondaryWeapons_gui_accSlot;
		};
		
		if(((_SecondaryWeaponItems select 0) select 2) != "") then
		{
			((_SecondaryWeaponItems select 0) select 2) call SecondaryWeapons_gui_opticSlot;
		};
		
		if(((_SecondaryWeaponItems select 0) select 3) != "") then
		{
			((_SecondaryWeaponItems select 0) select 3) call SecondaryWeapons_gui_underSlot;
		};
		
		if(count (_SecondaryWeaponItems select 1) > 0) then
		{
			(_SecondaryWeaponItems select 1) call SecondaryWeapons_gui_magazineSlot;
		};
	} 
	else 
	{
		SecondaryWeaponsClassName = "";
	};
}
catch 
{
	_throw = _exception;
};
_throw



