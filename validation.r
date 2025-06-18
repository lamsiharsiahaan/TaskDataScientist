install.packages("ggplot2")

# === Load libraries ===
library(glmtoolbox)
library(ggplot2)
library(dplyr)

# === 1. Baca file hasil prediksi ===
df <- read.csv("credit_predictions.csv")

# Pastikan strukturnya benar
str(df)

# === 2. Hosmer-Lemeshow Test (dengan transformasi logit) ===
df$predicted_logit <- log(df$prob / (1 - df$prob))  # untuk membentuk model

glm_model <- glm(default ~ predicted_logit, data = df, family = binomial())

hl_result <- hltest(glm_model, g = 10)
print("=== Hosmer-Lemeshow Test ===")
print(hl_result)


# === 3. Calibration Curve ===
df_grouped <- df %>%
  mutate(prob_bin = cut(prob, breaks = seq(0, 1, by = 0.1), include.lowest = TRUE)) %>%
  group_by(prob_bin) %>%
  summarise(
    avg_prob = mean(prob),
    actual_default = mean(default)
  )

# grafik Plot
ggplot(df_grouped, aes(x = avg_prob, y = actual_default)) +
  geom_line(color = "steelblue", size = 1.2) +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "gray") +
  labs(
    title = "Calibration Curve",
    x = "Predicted Probability",
    y = "Observed Default Rate"
  ) +
  theme_minimal()