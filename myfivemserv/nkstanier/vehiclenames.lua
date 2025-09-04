local data = {
    -- Model name
    ["nkstanier"] = "Stanier Police Cruiser",
    -- Callsigns Left
    ["NKSTAN_CSIGN_L0"] = "Num. O",
    ["NKSTAN_CSIGN_L1"] = "Num. 1",
    ["NKSTAN_CSIGN_L2"] = "Num. 2",
    ["NKSTAN_CSIGN_L3"] = "Num. 3",
    ["NKSTAN_CSIGN_L4"] = "Num. 4",
    ["NKSTAN_CSIGN_L5"] = "Num. 5",
    ["NKSTAN_CSIGN_L6"] = "Num. 6",
    ["NKSTAN_CSIGN_L7"] = "Num. 7",
    ["NKSTAN_CSIGN_L8"] = "Num. 8",
    ["NKSTAN_CSIGN_L9"] = "Num. 9",
    -- Callsigns Center
    ["NKSTAN_CSIGN_C0"] = "Num. 0",
    ["NKSTAN_CSIGN_C1"] = "Num. 1",
    ["NKSTAN_CSIGN_C2"] = "Num. 2",
    ["NKSTAN_CSIGN_C3"] = "Num. 3",
    ["NKSTAN_CSIGN_C4"] = "Num. 4",
    ["NKSTAN_CSIGN_C5"] = "Num. 5",
    ["NKSTAN_CSIGN_C6"] = "Num. 6",
    ["NKSTAN_CSIGN_C7"] = "Num. 7",
    ["NKSTAN_CSIGN_C8"] = "Num. 8",
    ["NKSTAN_CSIGN_C9"] = "Num. 9",
    -- Callsigns Right
    ["NKSTAN_CSIGN_R0"] = "Num. 0",
    ["NKSTAN_CSIGN_R1"] = "Num. 1",
    ["NKSTAN_CSIGN_R2"] = "Num. 2",
    ["NKSTAN_CSIGN_R3"] = "Num. 3",
    ["NKSTAN_CSIGN_R4"] = "Num. 4",
    ["NKSTAN_CSIGN_R5"] = "Num. 5",
    ["NKSTAN_CSIGN_R6"] = "Num. 6",
    ["NKSTAN_CSIGN_R7"] = "Num. 7",
    ["NKSTAN_CSIGN_R8"] = "Num. 8",
    ["NKSTAN_CSIGN_R9"] = "Num. 9",
    -- Callsigns Boot Left
    ["NKSTAN_CSIGN_RL0"] = "Num. 0",
    ["NKSTAN_CSIGN_RL1"] = "Num. 1",
    ["NKSTAN_CSIGN_RL2"] = "Num. 2",
    ["NKSTAN_CSIGN_RL3"] = "Num. 3",
    ["NKSTAN_CSIGN_RL4"] = "Num. 4",
    ["NKSTAN_CSIGN_RL5"] = "Num. 5",
    ["NKSTAN_CSIGN_RL6"] = "Num. 6",
    ["NKSTAN_CSIGN_RL7"] = "Num. 7",
    ["NKSTAN_CSIGN_RL8"] = "Num. 8",
    ["NKSTAN_CSIGN_RL9"] = "Num. 9",
    -- Callsigns Boot Right
    ["NKSTAN_CSIGN_RR0"] = "Num. 0",
    ["NKSTAN_CSIGN_RR1"] = "Num. 1",
    ["NKSTAN_CSIGN_RR2"] = "Num. 2",
    ["NKSTAN_CSIGN_RR3"] = "Num. 3",
    ["NKSTAN_CSIGN_RR4"] = "Num. 4",
    ["NKSTAN_CSIGN_RR5"] = "Num. 5",
    ["NKSTAN_CSIGN_RR6"] = "Num. 6",
    ["NKSTAN_CSIGN_RR7"] = "Num. 7",
    ["NKSTAN_CSIGN_RR8"] = "Num. 8",
    ["NKSTAN_CSIGN_RR9"] = "Num. 9",
    -- Callsigns Letters
    ["NKSTAN_CSIGN_A"] = "Char. A",
    ["NKSTAN_CSIGN_B"] = "Char. B",
    ["NKSTAN_CSIGN_C"] = "Char. C",
    ["NKSTAN_CSIGN_D"] = "Char. D",
    ["NKSTAN_CSIGN_E"] = "Char. E",
    ["NKSTAN_CSIGN_F"] = "Char. F",
    -- ALPR's
    ["NKSTAN_ALPRS"] = "Lightbar ALPR's",
    ["NKSTAN_ALPROLD1"] = "Old Type ALPR Front",
    ["NKSTAN_ALPROLD2"] = "Old Type ALPR Rear",
    ["NKSTAN_ALPROLD3"] = "Old Type ALPR Together",
    -- Rank System
    ["NKSTAN_PUNIT_L"] = "Patrol Unit",
    ["NKSTAN_COMM_L"] = "Command",
    ["NKSTAN_SVISOR_L"] = "Supervisor",
    ["NKSTAN_K9UNIT_L"] = "K9 Unit",
    ["NKSTAN_GUNIT_L"] = "Gang Unit",
    ["NKSTAN_BSQUAD_L"] = "Bomb Squad",
    -- Spotlights
    ["NKSTAN_SLIGHTB"] = "Folded Spotlight",
    ["NKSTAN_SLIGHTC"] = "One Unfolded Spotlight",
    ["NKSTAN_SLIGHTD"] = "Folded Spotlights",
    ["NKSTAN_SLIGHTE"] = "One Folded Spotlight",
    ["NKSTAN_SLIGHTF"] = "Unfolded Spotlights",
    -- Loudspeaker
    ["NKSTAN_LSPEAKER"] = "Pushbar Loudspeaker",
    -- Antennas Front
    ["NKSTAN_ANT_F1"] = "Antennas Set 1",
    ["NKSTAN_ANT_F2"] = "Antennas Set 2",
    -- Antennas Rear
    ["NKSTAN_ANT_R1"] = "Antennas Set 1",
    ["NKSTAN_ANT_R2"] = "Antennas Set 2",
    ["NKSTAN_ANT_R3"] = "Antennas Set 3",
    ["NKSTAN_ANT_R4"] = "Antennas Set 4",
    ["NKSTAN_ANT_R5"] = "Antennas Set 5",
    -- Laptop
    ["NKSTAN_LAPT"] = "Police Laptop",
    -- Radar
    ["NKSTAN_RADA"] = "Police Radar",
    -- Shotgun
    ["NKSTAN_GUNS"] = "Police Shotgun",
    -- Camera
    ["NKSTAN_CAM"] = "Police Dash Camera",
    -- Trunk Supplies
    ["NKSTAN_TSUPPL"] = "Police Trunk Supplies",
    -- Liveries
    ["NKSTAN_LIVLSPD"] = "LSPD Livery",
    ["NKSTAN_LIVBCSO"] = "BCSO Livery",
    ["NKSTAN_LIVSAST"] = "SAST Livery",
    -- Stock
    ["tfstanier_bootaccs1"] = "Half Plastic Rear Facia",
    ["tfstanier_bootaccs2"] = "Plastic Rear Facia",
    ["tfstanier_bootaccs3"] = "America Rear Facia",
    ["tfstanier_boottrim1a"] = "Plastic Rear Trim",
    ["tfstanier_boottrim2a"] = "Plastic Rear Trim",
    ["tfstanier_dtrim1lf"] = "Door Trim",
    ["tfstanier_grille1"] = "Plastic Grille",
    ["tfstanier_grille2"] = "Painted Grille",
    ["tfstanier_grille3"] = "Chrome Alt Grille",
    ["tfstanier_grille4"] = "Plastic Alt Grille",
    ["tfstanier_grille5"] = "Painted Alt Grille",
    ["tfstanier_wing1"] = "Primary Ducttail",
}

for entryHash, entryValue in pairs(data) do
    AddTextEntry(entryHash, entryValue)
end
