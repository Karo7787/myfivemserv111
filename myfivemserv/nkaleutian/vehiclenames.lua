local data = {
    -- Model name
    ["nkaleutian"] = "Aleutian Police Cruiser",
    -- Callsigns Left
    ["NKALEU_CSIGN_L0"] = "Num. O",
    ["NKALEU_CSIGN_L1"] = "Num. 1",
    ["NKALEU_CSIGN_L2"] = "Num. 2",
    ["NKALEU_CSIGN_L3"] = "Num. 3",
    ["NKALEU_CSIGN_L4"] = "Num. 4",
    ["NKALEU_CSIGN_L5"] = "Num. 5",
    ["NKALEU_CSIGN_L6"] = "Num. 6",
    ["NKALEU_CSIGN_L7"] = "Num. 7",
    ["NKALEU_CSIGN_L8"] = "Num. 8",
    ["NKALEU_CSIGN_L9"] = "Num. 9",
    -- Callsigns Center
    ["NKALEU_CSIGN_C0"] = "Num. 0",
    ["NKALEU_CSIGN_C1"] = "Num. 1",
    ["NKALEU_CSIGN_C2"] = "Num. 2",
    ["NKALEU_CSIGN_C3"] = "Num. 3",
    ["NKALEU_CSIGN_C4"] = "Num. 4",
    ["NKALEU_CSIGN_C5"] = "Num. 5",
    ["NKALEU_CSIGN_C6"] = "Num. 6",
    ["NKALEU_CSIGN_C7"] = "Num. 7",
    ["NKALEU_CSIGN_C8"] = "Num. 8",
    ["NKALEU_CSIGN_C9"] = "Num. 9",
    -- Callsigns Right
    ["NKALEU_CSIGN_R0"] = "Num. 0",
    ["NKALEU_CSIGN_R1"] = "Num. 1",
    ["NKALEU_CSIGN_R2"] = "Num. 2",
    ["NKALEU_CSIGN_R3"] = "Num. 3",
    ["NKALEU_CSIGN_R4"] = "Num. 4",
    ["NKALEU_CSIGN_R5"] = "Num. 5",
    ["NKALEU_CSIGN_R6"] = "Num. 6",
    ["NKALEU_CSIGN_R7"] = "Num. 7",
    ["NKALEU_CSIGN_R8"] = "Num. 8",
    ["NKALEU_CSIGN_R9"] = "Num. 9",
    -- Callsigns Boot Left
    ["NKALEU_CSIGN_RL0"] = "Num. 0",
    ["NKALEU_CSIGN_RL1"] = "Num. 1",
    ["NKALEU_CSIGN_RL2"] = "Num. 2",
    ["NKALEU_CSIGN_RL3"] = "Num. 3",
    ["NKALEU_CSIGN_RL4"] = "Num. 4",
    ["NKALEU_CSIGN_RL5"] = "Num. 5",
    ["NKALEU_CSIGN_RL6"] = "Num. 6",
    ["NKALEU_CSIGN_RL7"] = "Num. 7",
    ["NKALEU_CSIGN_RL8"] = "Num. 8",
    ["NKALEU_CSIGN_RL9"] = "Num. 9",
    -- Callsigns Boot Right
    ["NKALEU_CSIGN_RR0"] = "Num. 0",
    ["NKALEU_CSIGN_RR1"] = "Num. 1",
    ["NKALEU_CSIGN_RR2"] = "Num. 2",
    ["NKALEU_CSIGN_RR3"] = "Num. 3",
    ["NKALEU_CSIGN_RR4"] = "Num. 4",
    ["NKALEU_CSIGN_RR5"] = "Num. 5",
    ["NKALEU_CSIGN_RR6"] = "Num. 6",
    ["NKALEU_CSIGN_RR7"] = "Num. 7",
    ["NKALEU_CSIGN_RR8"] = "Num. 8",
    ["NKALEU_CSIGN_RR9"] = "Num. 9",
    -- Callsigns Letters
    ["NKALEU_CSIGN_A"] = "Char. A",
    ["NKALEU_CSIGN_B"] = "Char. B",
    ["NKALEU_CSIGN_C"] = "Char. C",
    ["NKALEU_CSIGN_D"] = "Char. D",
    ["NKALEU_CSIGN_E"] = "Char. E",
    ["NKALEU_CSIGN_F"] = "Char. F",
    -- ALPR's
    ["NKALEU_ALPRS"] = "Lightbar ALPR's",
    ["NKALEU_ALPROLD1"] = "Old Type ALPR Front",
    ["NKALEU_ALPROLD2"] = "Old Type ALPR Rear",
    ["NKALEU_ALPROLD3"] = "Old Type ALPR Together",
    -- Rank System
    ["NKALEU_PUNIT_L"] = "Patrol Unit",
    ["NKALEU_COMM_L"] = "Command",
    ["NKALEU_SVISOR_L"] = "Supervisor",
    ["NKALEU_K9UNIT_L"] = "K9 Unit",
    ["NKALEU_GUNIT_L"] = "Gang Unit",
    ["NKALEU_BSQUAD_L"] = "Bomb Squad",
    -- Spotlights
    ["NKALEU_SLIGHTB"] = "Folded Spotlight",
    ["NKALEU_SLIGHTC"] = "One Unfolded Spotlight",
    ["NKALEU_SLIGHTD"] = "Folded Spotlights",
    ["NKALEU_SLIGHTE"] = "One Folded Spotlight",
    ["NKALEU_SLIGHTF"] = "Unfolded Spotlights",
    -- Loudspeaker
    ["NKALEU_LSPEAKER"] = "Pushbar Loudspeaker",
    -- Antennas Front
    ["NKALEU_ANT_F1"] = "Antennas Set 1",
    ["NKALEU_ANT_F2"] = "Antennas Set 2",
    -- Antennas Rear
    ["NKALEU_ANT_R1"] = "Antennas Set 1",
    ["NKALEU_ANT_R2"] = "Antennas Set 2",
    ["NKALEU_ANT_R3"] = "Antennas Set 3",
    ["NKALEU_ANT_R4"] = "Antennas Set 4",
    ["NKALEU_ANT_R5"] = "Antennas Set 5",
    -- Laptop
    ["NKALEU_LAPT"] = "Police Laptop",
    -- Radar
    ["NKALEU_RADA"] = "Police Radar",
    -- Siren Controller
    ["NKALEU_SCON"] = "Siren Controller",
    -- Camera
    ["NKALEU_CAM"] = "Police Dash Camera",
    -- Trunk Supplies
    ["NKALEU_TSUPPL"] = "Police Trunk Supplies",
    -- Liveries
    ["NKALEU_LIVLSPD"] = "LSPD Livery",
    ["NKALEU_LIVBCSO"] = "BCSO Livery",
    ["NKALEU_LIVSAST"] = "SAST Livery",
    ["NKALEU_LIVLSPDv2"] = "LSPD Livery",

    -- Wraparound Pushbar's
    ["NKALEU_WAR1"] = "Wraparound Pushbar Opt. 1",
    ["NKALEU_WAR2"] = "Wraparound Pushbar Opt. 2",
    ["NKALEU_WAR3"] = "Wraparound Pushbar Opt. 3",

}

for entryHash, entryValue in pairs(data) do
    AddTextEntry(entryHash, entryValue)
end
