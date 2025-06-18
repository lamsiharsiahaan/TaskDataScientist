# TaskDataScientist


# 📊 Credit Scoring Project

Proyek ini bertujuan untuk melakukan analisis data, membangun model prediksi gagal bayar menggunakan Python dan validasi statistik menggunakan R.

## 🔧 Struktur Folder

```
.
├── A_analysis.sql         # RFM dan repeat purchase SQL
├── A_findings.md          # Temuan anomali decoy_noise
├── B_modelling.ipynb      # Notebook Python EDA, modeling, scorecard, SHAP
├── credit_predictions.csv # Output prediksi probabilitas default
├── validation.R           # Validasi Hosmer-Lemeshow & Calibration curve
├── C_summary.md           # Cut-off skor dengan expected default ≤ 5%
├── decision_slide.pdf     # Keputusan IDR 5 juta (1-slide)
```

## ▶️ Cara Menjalankan

### A. SQL Analytics
1. Jalankan `A_analysis.sql` di database MySQL atau BigQuery.
2. Hasilkan output untuk:
   - RFM segmentation
   - Repeat purchase bulanan

### B. Python Modeling
1. Buka `B_modelling.ipynb` dengan Jupyter / VSCode.
2. Jalankan sel bertahap:
   - EDA & drop leakage column
   - Logistic Regression baseline
   - Gradient Boosting Classifier
   - Scorecard (skala 300–850)
   - SHAP explainability
3. Simpan hasil prediksi ke `credit_predictions.csv`

```bash
pip install pandas scikit-learn matplotlib shap
```

### C. R Statistical Check
1. Pastikan file `credit_predictions.csv` ada di direktori R.
2. Jalankan `validation.R` di RStudio atau VSCode.
3. Instalasi package jika perlu:

```r
install.packages("glmtoolbox")
install.packages("ggplot2")
install.packages("dplyr")
```

## 📌 Hasil Utama
- AUC GB: 0.6863
- HL-test p-value: 0.0208
- Cut-off score (default ≤ 5%): kurang lebih diatas 823
