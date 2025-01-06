module UmcPathologyStructure
  extend ActiveSupport::Concern

  # Define test categories and their associated tests
  TEST_CATEGORIES = {
    cumulative_report: {
      label: "CUMULATIVE REPORT",
      tests: [
        "Sodium", "Na", "Sodium (Na)",
        "Potassium", "K", "Potassium (K)",
        "Carbon Dioxide", "CO2", "Carbon Dioxide (CO2)",
        "Chloride", "Cl", "Chloride (Cl)",
        "Glucose",
        "Calcium", "Ca", "Calcium (Ca)",
        "Blood Urea Nitrogen", "BUN",
        "Creatinine",
        "Hemoglobin", "HB", "Hgb", "Hemoglobin (HB/Hgb)",
        "Hematocrit", "HCT", "Hematocrit (HCT)",
        "Hemoglobin A1c", "A1c",
        "HIV-1 RNA Quant",
        "Vitamin B12", "B12",
        "Folate",
        "Throat Culture"
      ]
    },
    blood_count: {
      label: "BLOOD COUNT REPORT",
      tests: [
        "White Blood Cell", "WBC",
        "Red Blood Cell", "RBC",
        "Mean Cell Volume", "MCV",
        "Mean Cell Hemoglobin", "MCH",
        "Mean Cell Hb Conc", "MCHC",
        "Red Cell Dist Width", "RDW",
        "Platelet count",
        "Mean Platelet Volume",
        "Neutrophil", "Neut",
        "Lymphocyte", "Lymph",
        "Monocyte", "Mono",
        "Eosinophil", "Eos",
        "Basophil", "Baso",
        "Neutrophil, Absolute",
        "Lymphocyte, Absolute",
        "Monocyte, Absolute",
        "Eosinophil, Absolute",
        "Basophil, Absolute"
      ]
    }
  }.freeze

  # Standard test name mappings
  TEST_NAME_MAPPINGS = {
    "Na" => "Sodium (Na)",
    "K" => "Potassium (K)",
    "CO2" => "Carbon Dioxide (CO2)",
    "Cl" => "Chloride (Cl)",
    "Ca" => "Calcium (Ca)",
    "BUN" => "Blood Urea Nitrogen (BUN)",
    "HB" => "Hemoglobin (HB/Hgb)",
    "Hgb" => "Hemoglobin (HB/Hgb)",
    "HCT" => "Hematocrit (HCT)",
    "B12" => "Vitamin B12 (B12)",
    "WBC" => "White Blood Cell (WBC)",
    "RBC" => "Red Blood Cell (RBC)"
  }.freeze

  # Define flags and their meanings
  TEST_FLAGS = {
    "H" => "High",
    "L" => "Low",
    "C" => "Critical",
    "*" => "Abnormal",
    "A" => "Abnormal",
    nil => "Normal"
  }.freeze

  # Common units and their standardized forms
  STANDARDIZED_UNITS = {
    "mg/dL" => "mg/dL",
    "g/dL" => "g/dL",
    "mEq/L" => "mEq/L",
    "K/uL" => "K/µL",
    "M/uL" => "M/µL",
    "%" => "%",
    "mg/L" => "mg/L",
    "U/L" => "U/L",
    "fL" => "fL",
    "pg" => "pg",
    "copies/mL" => "copies/mL",
    "pg/mL" => "pg/mL",
    "ng/mL" => "ng/mL"
  }.freeze
end 