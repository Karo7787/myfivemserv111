local data = {
    -- Model name
    ["nktorrence"] = "Torrence LE Police Cruiser",
    -- Callsigns Left
    ["NKTORR_CSIGN_L0"] = "Num. O",
    ["NKTORR_CSIGN_L1"] = "Num. 1",
    ["NKTORR_CSIGN_L2"] = "Num. 2",
    ["NKTORR_CSIGN_L3"] = "Num. 3",
    ["NKTORR_CSIGN_L4"] = "Num. 4",
    ["NKTORR_CSIGN_L5"] = "Num. 5",
    ["NKTORR_CSIGN_L6"] = "Num. 6",
    ["NKTORR_CSIGN_L7"] = "Num. 7",
    ["NKTORR_CSIGN_L8"] = "Num. 8",
    ["NKTORR_CSIGN_L9"] = "Num. 9",
    -- Callsigns Center
    ["NKTORR_CSIGN_C0"] = "Num. 0",
    ["NKTORR_CSIGN_C1"] = "Num. 1",
    ["NKTORR_CSIGN_C2"] = "Num. 2",
    ["NKTORR_CSIGN_C3"] = "Num. 3",
    ["NKTORR_CSIGN_C4"] = "Num. 4",
    ["NKTORR_CSIGN_C5"] = "Num. 5",
    ["NKTORR_CSIGN_C6"] = "Num. 6",
    ["NKTORR_CSIGN_C7"] = "Num. 7",
    ["NKTORR_CSIGN_C8"] = "Num. 8",
    ["NKTORR_CSIGN_C9"] = "Num. 9",
    -- Callsigns Right
    ["NKTORR_CSIGN_R0"] = "Num. 0",
    ["NKTORR_CSIGN_R1"] = "Num. 1",
    ["NKTORR_CSIGN_R2"] = "Num. 2",
    ["NKTORR_CSIGN_R3"] = "Num. 3",
    ["NKTORR_CSIGN_R4"] = "Num. 4",
    ["NKTORR_CSIGN_R5"] = "Num. 5",
    ["NKTORR_CSIGN_R6"] = "Num. 6",
    ["NKTORR_CSIGN_R7"] = "Num. 7",
    ["NKTORR_CSIGN_R8"] = "Num. 8",
    ["NKTORR_CSIGN_R9"] = "Num. 9",
    -- Callsigns Boot Left
    ["NKTORR_CSIGN_RL0"] = "Num. 0",
    ["NKTORR_CSIGN_RL1"] = "Num. 1",
    ["NKTORR_CSIGN_RL2"] = "Num. 2",
    ["NKTORR_CSIGN_RL3"] = "Num. 3",
    ["NKTORR_CSIGN_RL4"] = "Num. 4",
    ["NKTORR_CSIGN_RL5"] = "Num. 5",
    ["NKTORR_CSIGN_RL6"] = "Num. 6",
    ["NKTORR_CSIGN_RL7"] = "Num. 7",
    ["NKTORR_CSIGN_RL8"] = "Num. 8",
    ["NKTORR_CSIGN_RL9"] = "Num. 9",
    -- Callsigns Boot Right
    ["NKTORR_CSIGN_RR0"] = "Num. 0",
    ["NKTORR_CSIGN_RR1"] = "Num. 1",
    ["NKTORR_CSIGN_RR2"] = "Num. 2",
    ["NKTORR_CSIGN_RR3"] = "Num. 3",
    ["NKTORR_CSIGN_RR4"] = "Num. 4",
    ["NKTORR_CSIGN_RR5"] = "Num. 5",
    ["NKTORR_CSIGN_RR6"] = "Num. 6",
    ["NKTORR_CSIGN_RR7"] = "Num. 7",
    ["NKTORR_CSIGN_RR8"] = "Num. 8",
    ["NKTORR_CSIGN_RR9"] = "Num. 9",
    -- Callsigns Letters
    ["NKTORR_CSIGN_A"] = "Char. A",
    ["NKTORR_CSIGN_B"] = "Char. B",
    ["NKTORR_CSIGN_C"] = "Char. C",
    ["NKTORR_CSIGN_D"] = "Char. D",
    ["NKTORR_CSIGN_E"] = "Char. E",
    ["NKTORR_CSIGN_F"] = "Char. F",
    -- ALPR's
    ["NKTORR_ALPRS"] = "Lightbar ALPR's",
    ["NKTORR_ALPROLD1"] = "Old Type ALPR Front",
    ["NKTORR_ALPROLD2"] = "Old Type ALPR Rear",
    ["NKTORR_ALPROLD3"] = "Old Type ALPR Together",
    -- Rank System
    ["NKTORR_PUNIT_L"] = "Patrol Unit",
    ["NKTORR_COMM_L"] = "Command",
    ["NKTORR_SVISOR_L"] = "Supervisor",
    ["NKTORR_K9UNIT_L"] = "K9 Unit",
    ["NKTORR_GUNIT_L"] = "Gang Unit",
    ["NKTORR_BSQUAD_L"] = "Bomb Squad",
    -- Spotlights
    ["NKTORR_SLIGHTB"] = "Folded Spotlight",
    ["NKTORR_SLIGHTC"] = "One Unfolded Spotlight",
    ["NKTORR_SLIGHTD"] = "Folded Spotlights",
    ["NKTORR_SLIGHTE"] = "One Folded Spotlight",
    ["NKTORR_SLIGHTF"] = "Unfolded Spotlights",
    -- Loudspeaker
    ["NKTORR_LSPEAKER"] = "Pushbar Loudspeaker",
    -- Antennas Front
    ["NKTORR_ANT_F1"] = "Antennas Set 1",
    ["NKTORR_ANT_F2"] = "Antennas Set 2",
    -- Antennas Rear
    ["NKTORR_ANT_R1"] = "Antennas Set 1",
    ["NKTORR_ANT_R2"] = "Antennas Set 2",
    ["NKTORR_ANT_R3"] = "Antennas Set 3",
    ["NKTORR_ANT_R4"] = "Antennas Set 4",
    ["NKTORR_ANT_R5"] = "Antennas Set 5",
    -- Laptop
    ["NKTORR_LAPT"] = "Police Laptop",
    -- Radar
    ["NKTORR_RADA"] = "Police Radar",
    -- Siren Controller
    ["NKTORR_SCON"] = "Siren Controller",
    -- Shotgun
    ["NKTORR_GUNS"] = "Police Shotgun",
    -- Camera
    ["NKTORR_CAM"] = "Police Dash Camera",
    -- Trunk Supplies
    ["NKTORR_TSUPPL"] = "Police Trunk Supplies",
    -- Liveries
    ["NKTORR_LIVLSPD"] = "LSPD Livery",
    ["NKTORR_LIVBCSO"] = "BCSO Livery",
    ["NKTORR_LIVSAST"] = "SAST Livery",
}

for entryHash, entryValue in pairs(data) do
    AddTextEntry(entryHash, entryValue)
end
