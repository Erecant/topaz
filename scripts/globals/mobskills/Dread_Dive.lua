---------------------------------------------
--  Dread Dive
--
--  Description: Dives into a single target. Additional effect: Knockback + Stun
--  Type: Physical
--  Utsusemi/Blink absorb: 1 shadow
--  Range: Melee
--  Notes: Used instead of Gliding Spike by certain notorious monsters.
---------------------------------------------

require("/scripts/globals/settings");
require("/scripts/globals/status");
require("/scripts/globals/monstertpmoves");

---------------------------------------------

function OnMobSkillCheck(target,mob,skill)
	return 0;
end;

function OnMobWeaponSkill(target, mob, skill)
	local typeEffect = EFFECT_STUN;
	if(target:hasStatusEffect(typeEffect) == false) then
		local accrand = math.random(1,2);
		if(accrand == 1) then
			local statmod = MOD_INT;
			local resist = applyPlayerResistance(mob,skill,target,mob:getMod(statmod)-target:getMod(statmod),0,6);
			if(resist > 0.5) then
				target:addStatusEffect(typeEffect,1,0,6);--power=1;tic=0;duration=6;
			end
		end
	end

	local numhits = 1;
	local accmod = 1;
	local dmgmod = 1;
	local info = MobPhysicalMove(mob,target,skill,numhits,accmod,dmgmod,TP_NO_EFFECT);
	local dmg = MobFinalAdjustments(info.dmg,mob,skill,target,MOBSKILL_PHYSICAL,MOBPARAM_NONE,info.hitslanded);
	target:delHP(dmg);
	return dmg;
end;
