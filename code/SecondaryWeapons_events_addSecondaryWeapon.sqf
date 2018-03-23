/**
 * SecondaryWeapons_events_addSecondaryWeapon
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

private ["_buttonDown", "_weapon", "_error", "_wpItems", "_secondaryWeapon", "_dialog", "_BG", "_slot", "_buttonUp", "_cover", "_pic", "_icoB", "_ico", "_SecondaryWeaponItems"];

_weapon = _this;
_error = false;
_wpItems = [];

_secondaryWeapon = format["%1%2",_weapon,"_secondary"];

disableSerialization;

if(SecondaryWeaponsClassName != "") exitWith { (primaryWeapon player) spawn SecondaryWeapons_events_swapSecondaryWeapon; }; 
if(_weapon == "") exitWith { systemchat "You need some milk."; };
if(SecondaryWeaponsSwapping) exitWith {};
if(!(isClass (configFile >> "CfgWeapons" >> _secondaryWeapon))) exitWith { systemchat "The Weapon you are trying to put on your back is currently unsupported. Please post on the workshop to get support for your mod.";};

if(secondaryWeapon player != "") exitWith { systemchat "Nothing can be on your back if you want to put a second primary weapon there"; };

if(toLower _weapon in SecondaryWeaponsBlockedWeapons) exitWith { systemchat "That current weapon is not able to fit on your back!"; };

SecondaryWeaponsSwapping = true;

uisleep 1;
_wpItems = true call SecondaryWeapons_util_Ammo;
	
if((primaryWeapon player) == "") exitWith {SecondaryWeaponsSwapping = false;};
player removeWeapon _weapon;

SecondaryWeaponsClassName = _secondaryWeapon;
SecondaryWeaponsWeaponInfo = [];

player addWeapon SecondaryWeaponsClassName;

{
	if(_x != "") then 
	{
		if(toLower format["%1_secondary",_x] in getArray(configFile >> "cfgWeapons" >> SecondaryWeaponsClassName >> "WeaponSlotsInfo" >> "MuzzleSlot" >> "compatibleItems")) then
		{
			SecondaryWeaponsWeaponInfo pushBack (toLower format["%1_secondary",_x]);
		}
		else
		{
			player addSecondaryWeaponItem format["%1_secondary",_x];		
		};
	};
} forEach (_wpItems select 0);

if(count (_wpItems select 1) > 0) then
{
	player addWeaponItem [SecondaryWeaponsClassName, [format["%1_secondary",((_wpItems select 1) select 0)], ((_wpItems select 1) select 1)]];
};

if(count (_wpItems select 2) > 0) then
{
	SecondaryWeaponsWeaponInfo pushBack [toLower ((_wpItems select 2) select 0), ((_wpItems select 2) select 1)];
};
player setVariable ["SecondaryWeaponsWeaponInfo", SecondaryWeaponsWeaponInfo,true];
false call SecondaryWeapons_util_Ammo;

_dialog = uiNameSpace getVariable ["RscDisplayInventory", displayNull];
if !(_dialog isEqualTo displayNull) then
{
	_BG = _dialog displayCtrl 1247;
	_slot = _dialog displayCtrl 611;
	_buttonUp = _dialog displayCtrl 6969;
	_buttonUp ctrlEnable (SecondaryWeaponsClassName != "");
	_buttonUp ctrlCommit 0;
	
	_buttonDown = _dialog displayCtrl 1337;
	_buttonDown ctrlEnable (primaryWeapon player != "");
	_buttonDown ctrlCommit 0;

	_pos = ctrlPosition _slot;

	_cover = _dialog ctrlCreate ["RscText", 1530];

	_cover ctrlSetPosition _pos;
	_cover ctrlSetBackgroundColor [0.7,0.7,0.7,0.1];
	_cover ctrlCommit 0;
			   
	_pic = _dialog ctrlCreate ["RscPictureKeepAspect", 1531];

	_pic ctrlSetPosition _pos;
	_pic ctrlSetText (getText(configFile >> "cfgWeapons" >> _secondaryWeapon >> "img"));
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
};

if(SecondaryWeaponsAddAction) then
{
	player setUserActionText [SecondaryWeaponsSwapPrimary, format["Swap to Weapon %1", getText (configFile >> "CfgWeapons" >> (secondaryWeapon player) >> "displayName")]];
};

SecondaryWeaponsSwapping = false;