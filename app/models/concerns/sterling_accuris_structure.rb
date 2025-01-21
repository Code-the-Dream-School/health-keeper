module SterlingAccurisStructure
  STRUCTURE = {
    "Complete Blood Count" => {
      columns: ["Test", "Method", "Result", "Unit", "Biological Ref. Interval"],
      tests: ["Hemoglobin", "RBC Count", "Hematocrit", "MCV", "MCH", "MCHC", "RDW CV"]
    },
    "Total WBC and Differential Count" => {
      columns: ["Test", "Method", "Result", "Unit", "Biological Ref. Interval"],
      tests: ["WBC Count"]
    },
    "Differential Count" => {
      columns: ["Test", "Method", "Result", "Unit", "Absolute Count"],
      tests: ["Neutrophils", "Lymphocytes", "Eosinophils", "Monocytes", "Basophils", "Platelet Count", "MPV"]
    },
    "Peripheral Smear Examination" => {
      columns: ["Test", "Result"],
      tests: ["RBC Morphology", "WBC Morphology", "Platelets Morphology", "Parasites"]
    },
    "Erythrocyte Sedimentation Rate" => {
      columns: ["Test", "Result", "Unit", "Biological Ref. Interval"],
      tests: ["ESR"]
    },
    "Blood Group" => {
      columns: ["Test", "Result", "Unit", "Biological Ref. Interval"],
      tests: ["ABO Type", "Rh (D) Type"]
    },
    "Lipid Profile" => {
      columns: ["Test", "Result", "Unit", "Biological Ref. Interval"],
      tests: ["Cholesterol", "Triglyceride", "HDL Cholesterol", "Direct LDL", "VLDL", "CHOL/HDL Ratio", "LDL/HDL Ratio"]
    },
    "Biochemistry" => {
      columns: ["Test", "Result", "Unit", "Biological Ref. Interval"],
      tests: [
        "Fasting Blood Sugar",
        "Microalbumin (per urine volume)",
        "Creatinine, Serum",
        "Urea",
        "Blood Urea Nitrogen",
        "Uric Acid",
        "Calcium",
        "SGPT",
        "SGOT"
      ]
    },
    "HbA1c (Glycosylated Hemoglobin)" => {
      columns: ["Test", "Result", "Unit", "Biological Ref. Interval"],
      tests: ["HbA1c", "Mean Blood Glucose"]
    },
    "Thyroid Function Test" => {
      columns: ["Test", "Result", "Unit", "Biological Ref. Interval"],
      tests: ["T3 - Triiodothyronine", "T4 - Thyroxine", "TSH - Thyroid Stimulating Hormone"]
    },
    "Protein" => {
      columns: ["Test", "Result", "Unit", "Biological Ref. Interval"],
      tests: ["Total Protein", "Albumin", "Globulin", "A/G Ratio", "Total Bilirubin", "Conjugated Bilirubin", "Unconjugated Bilirubin", "Delta Bilirubin"]
    },
    "Iron Studies" => {
      columns: ["Test", "Result", "Unit", "Biological Ref. Interval"],
      tests: ["Iron", "Total Iron Binding Capacity (TIBC)", "Transferrin Saturation"]
    },
    "Immunoassay" => {
      columns: ["Test", "Result", "Unit", "Biological Ref. Interval"],
      tests: [
        "Homocysteine, Serum",
        "25(OH) Vitamin D",
        "Vitamin B12",
        "PSA-Prostate Specific Antigen, Total",
        "IgE",
        "HIV I & II Ab/Ag with P24 Ag",
        "Interpretation",
        "HBsAg"
      ]
    },
    "Electrolytes" => {
      columns: ["Test", "Result", "Unit", "Biological Ref. Interval"],
      tests: ["Sodium (Na+)", "Potassium (K+)", "Chloride (Cl-)"]
    },
    "HB Electrophoresis By HPLC" => {
      columns: ["Test", "Result", "Unit", "Biological Ref. Interval"],
      tests: ["Hb A", "Hb A2", "P2 Peak", "P3 Peak", "Foetal Hb", "Interpretation"]
    },
    "Bio-Rad CDM System" => {
      columns: ["Test", "Result"],
      tests: ["F Concentration", "A2 Concentration"]
    },
    "Physical & Chemical (Dip strip) examination" => {
      columns: ["Test", "Result", "Unit", "Biological Ref. Interval"],
      tests: ["Colour", "Clearity", "pH", "Specific Gravity", "Urine Glucose", "Urine Protein", "Bilirubin", "Urobilinogen", "Urine Ketone", "Nitrite"]
    },
    "Microscopic Examination" => {
      columns: ["Test", "Result", "Unit", "Biological Ref. Interval"],
      tests: ["Pus Cells", "Red Cells", "Epithelial Cells", "Casts", "Crystals", "Amorphous Material"]
    }
  }.freeze
end 