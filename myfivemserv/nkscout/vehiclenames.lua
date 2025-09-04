local data = {
    -- Model name
    ["nkscout"] = "Scout Police Interceptor",
    -- Callsigns Left
    ["NKSC_CSIGN_L0"] = "Num. O",
    ["NKSC_CSIGN_L1"] = "Num. 1",
    ["NKSC_CSIGN_L2"] = "Num. 2",
    ["NKSC_CSIGN_L3"] = "Num. 3",
    ["NKSC_CSIGN_L4"] = "Num. 4",
    ["NKSC_CSIGN_L5"] = "Num. 5",
    ["NKSC_CSIGN_L6"] = "Num. 6",
    ["NKSC_CSIGN_L7"] = "Num. 7",
    ["NKSC_CSIGN_L8"] = "Num. 8",
    ["NKSC_CSIGN_L9"] = "Num. 9",
    -- Callsigns Center
    ["NKSC_CSIGN_C0"] = "Num. 0",
    ["NKSC_CSIGN_C1"] = "Num. 1",
    ["NKSC_CSIGN_C2"] = "Num. 2",
    ["NKSC_CSIGN_C3"] = "Num. 3",
    ["NKSC_CSIGN_C4"] = "Num. 4",
    ["NKSC_CSIGN_C5"] = "Num. 5",
    ["NKSC_CSIGN_C6"] = "Num. 6",
    ["NKSC_CSIGN_C7"] = "Num. 7",
    ["NKSC_CSIGN_C8"] = "Num. 8",
    ["NKSC_CSIGN_C9"] = "Num. 9",
    -- Callsigns Right
    ["NKSC_CSIGN_R0"] = "Num. 0",
    ["NKSC_CSIGN_R1"] = "Num. 1",
    ["NKSC_CSIGN_R2"] = "Num. 2",
    ["NKSC_CSIGN_R3"] = "Num. 3",
    ["NKSC_CSIGN_R4"] = "Num. 4",
    ["NKSC_CSIGN_R5"] = "Num. 5",
    ["NKSC_CSIGN_R6"] = "Num. 6",
    ["NKSC_CSIGN_R7"] = "Num. 7",
    ["NKSC_CSIGN_R8"] = "Num. 8",
    ["NKSC_CSIGN_R9"] = "Num. 9",
    -- Callsigns Boot Left
    ["NKSC_CSIGN_RL0"] = "Num. 0",
    ["NKSC_CSIGN_RL1"] = "Num. 1",
    ["NKSC_CSIGN_RL2"] = "Num. 2",
    ["NKSC_CSIGN_RL3"] = "Num. 3",
    ["NKSC_CSIGN_RL4"] = "Num. 4",
    ["NKSC_CSIGN_RL5"] = "Num. 5",
    ["NKSC_CSIGN_RL6"] = "Num. 6",
    ["NKSC_CSIGN_RL7"] = "Num. 7",
    ["NKSC_CSIGN_RL8"] = "Num. 8",
    ["NKSC_CSIGN_RL9"] = "Num. 9",
    -- Callsigns Boot Right
    ["NKSC_CSIGN_RR0"] = "Num. 0",
    ["NKSC_CSIGN_RR1"] = "Num. 1",
    ["NKSC_CSIGN_RR2"] = "Num. 2",
    ["NKSC_CSIGN_RR3"] = "Num. 3",
    ["NKSC_CSIGN_RR4"] = "Num. 4",
    ["NKSC_CSIGN_RR5"] = "Num. 5",
    ["NKSC_CSIGN_RR6"] = "Num. 6",
    ["NKSC_CSIGN_RR7"] = "Num. 7",
    ["NKSC_CSIGN_RR8"] = "Num. 8",
    ["NKSC_CSIGN_RR9"] = "Num. 9",
    -- Callsigns Letters
    ["NKSC_CSIGN_A"] = "Char. A",
    ["NKSC_CSIGN_B"] = "Char. B",
    ["NKSC_CSIGN_C"] = "Char. C",
    ["NKSC_CSIGN_D"] = "Char. D",
    ["NKSC_CSIGN_E"] = "Char. E",
    ["NKSC_CSIGN_F"] = "Char. F",
    -- ALPR's
    ["NKSC_ALPRS"] = "Lightbar ALPR's",
    ["NKSC_ALPROLD1"] = "Old Type ALPR Front",
    ["NKSC_ALPROLD2"] = "Old Type ALPR Rear",
    ["NKSC_ALPROLD3"] = "Old Type ALPR Together",
    -- Rank System
    ["NKSC_PUNIT_L"] = "Patrol Unit",
    ["NKSC_COMM_L"] = "Command",
    ["NKSC_SVISOR_L"] = "Supervisor",
    ["NKSC_K9UNIT_L"] = "K9 Unit",
    ["NKSC_GUNIT_L"] = "Gang Unit",
    ["NKSC_BSQUAD_L"] = "Bomb Squad",
    -- Spotlights
    ["NKSC_SLIGHTB"] = "Folded Spotlight",
    ["NKSC_SLIGHTC"] = "One Unfolded Spotlight",
    ["NKSC_SLIGHTD"] = "Folded Spotlights",
    ["NKSC_SLIGHTE"] = "One Folded Spotlight",
    ["NKSC_SLIGHTF"] = "Unfolded Spotlights",
    -- Loudspeaker
    ["NKSC_LSPEAKER"] = "Pushbar Loudspeaker",
    -- Antennas Front
    ["NKSC_ANT_F1"] = "Antennas Set 1",
    ["NKSC_ANT_F2"] = "Antennas Set 2",
    -- Antennas Rear
    ["NKSC_ANT_R1"] = "Antennas Set 1",
    ["NKSC_ANT_R2"] = "Antennas Set 2",
    ["NKSC_ANT_R3"] = "Antennas Set 3",
    ["NKSC_ANT_R4"] = "Antennas Set 4",
    ["NKSC_ANT_R5"] = "Antennas Set 5",
    -- Laptop
    ["NKSC_LAPT"] = "Police Laptop",
    -- Radar
    ["NKSC_RADA"] = "Police Radar",
    -- Siren Controller
    ["NKSC_SCON"] = "Siren Controller",
    -- Shotgun
    ["NKSC_GUNS"] = "Police Shotgun",
    -- Camera
    ["NKSC_CAM"] = "Police Dash Camera",
    -- Trunk Supplies
    ["NKSC_TSUPPL"] = "Police Trunk Supplies",
    -- Liveries
    ["NKSC_LIVLSPD"] = "LSPD Livery",
    ["NKSC_LIVBCSO"] = "BCSO Livery",
    ["NKSC_LIVSAST"] = "SAST Livery",
}

for entryHash, entryValue in pairs(data) do
    AddTextEntry(entryHash, entryValue)
end
