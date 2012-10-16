---------------------------------------------
--  Curse
--
--  Description: Inflicts a curse on all targets in an area of effect.
--  Type: Enfeebling
--  Utsusemi/Blink absorb: Wipes shadows
--  Range: 15' radial 
--  Notes: Curse has a very long duration. 
---------------------------------------------
require("/scripts/globals/settings");
require("/scripts/globals/status");
require("/scripts/globals/monstertpmoves");

---------------------------------------------
function OnMobSkillCheck(target,mob,skill)
	return 0;
end;

function OnMobWeaponSkill(target, mob, skill)
	local message = MSG_MISS;
	local typeEffect = EFFECT_CURSE_I;
	if(target:hasStatusEffect(typeEffect) == false) then
		local accrand = math.random(1,2);
		if(accrand == 1) then
			local statmod = MOD_INT;
			local duration = 360;
			local resist = applyPlayerResistance(mob,skill,target,mob:getMod(statmod)-target:getMod(statmod),0,8);
			if(resist > 0.7) then         
				duration = duration - (duration/3);
			end
			if(resist > 0.5) then
				message = MSG_ENFEEB_IS;
				target:addStatusEffect(typeEffect,1,0,duration);--power=1;tic=0;
			end
		end
	else
		message = MSG_NO_EFFECT;
	end
	skill:setMsg(message);
	return typeEffect;
end;
