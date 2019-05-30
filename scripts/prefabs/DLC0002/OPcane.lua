local assets =
{
    Asset("ANIM", "anim/cane.zip"),
    Asset("ANIM", "anim/swap_cane.zip"),
}

local function onfinished(inst)
    inst:Remove()
end

local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "swap_cane", "swap_cane")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")

    local light = inst.entity:AddLight()
    light:SetFalloff(0.7)
    light:SetIntensity(.9)
    light:SetRadius(0.9)
    light:SetColour(237 / 255, 237 / 255, 209 / 255)
    light:Enable(true)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
end

local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end

local function fn(Sim, target, inst)
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst, "idle_water", "idle")

    anim:SetBank("cane")
    anim:SetBuild("cane")
    anim:PlayAnimation("idle")
    --------------------------------------
    local light = inst.entity:AddLight()
    light:SetFalloff(0.7)
    light:SetIntensity(.5)
    light:SetRadius(0.5)
    light:SetColour(237 / 255, 237 / 255, 209 / 255)
    light:Enable(true)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")

    ---------------------------------
    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(TUNING.SPEAR_DAMAGE) --makes like spear damage

    inst:AddInherentAction(ACTIONS.TERRAFORM)

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")

    inst:AddComponent("equippable")

    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    inst.components.equippable.walkspeedmult = TUNING.CANE_SPEED_MULT
    inst:AddTag("OPcane")
    inst:AddComponent("tool")
    --inst:AddComponent("key") -- works with "Target"
    inst:AddComponent("workable")
    inst:AddComponent("terraformer")
    inst:AddComponent("shaver")
    inst.components.tool:SetAction(ACTIONS.MINE)
    inst.components.tool:SetAction(ACTIONS.CHOP)
    inst.components.tool:SetAction(ACTIONS.DIG)
    inst.components.tool:SetAction(ACTIONS.HACK)
    inst.components.tool:SetAction(ACTIONS.HAMMER)
    inst.components.tool:SetAction(ACTIONS.TERRAFORM)
    inst.components.tool:SetAction(ACTIONS.SHAVE)
    -----------
    return inst
end

-------------------------

return Prefab("common/inventory/cane", fn, assets)
