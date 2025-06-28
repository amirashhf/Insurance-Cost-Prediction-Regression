#Import Module & Package
library(tidyr)
library(dplyr)
library(ggplot2)
library(GGally)
library(car)
library(lmtest)
library(olsrr)
library(DAAG)

#Modelling dari data asli kaggle tanpa dilakukan preprocessing (penghapusan outlier)
insurance <- read.csv("insurance (1).csv")
View(insurance)
model_all <- lm(charges~., data = insurance)

#Metode backward elimination
step(model_all, direction = "backward")
model1 <- lm(formula = charges ~ age + bmi + children + smoker + region, data = insurance)
summary(model1)

#Metode forward selection
step(model_all, direction = "forward")
model2 <- lm(formula = charges ~ age + sex + bmi + children + smoker + region, data = insurance)
summary(model2)

#Modifikasi hasil model dari metode backward dan forward berdasarkan analisa terhadap kondisi real
insurance$age2 <- insurance$age^2
insurance$bmi30 <- ifelse(insurance$bmi >= 30, 1, 0)
model3 <- lm(formula = charges ~ age + bmi + children + smoker + bmi30*smoker + region, data = insurance)
summary(model3)

model4 <- lm(formula = charges ~ age + age2 + sex + bmi + children + smoker + bmi30*smoker + region, data = insurance)
summary(model4)

#Transformasi logaritmik pada variabel charges
modeltransform<- lm(log(charges) ~ age + bmi + children + sex + smoker + region, data = insurance)
summary(modeltransform)

#----------------------------------------------------------------

#Modelling dari data asli kaggle setelah dilakukan preprocessing (penghapusan outlier)
insurance2 <- read.csv("data_prepro.csv")
View(insurance2)
model_all2 <- lm(charges~., data = insurance2)

#Metode backward elimination
step(model_all2, direction = "backward")
model5 <- lm(formula = charges ~ age + sex + bmi + children + smoker + region, data = insurance2)
summary(model5)

#Metode forward selection
insurance2$age2 <- insurance2$age^2
step(model_all2, direction = "forward")
model6 <- lm(formula = charges ~ age + sex + bmi + children + smoker + region, data = insurance2)
summary(model6)

#Modifikasi hasil model dari metode backward dan forward berdasarkan analisa terhadap kondisi real 
insurance2$bmi30 <- ifelse(insurance2$bmi >= 30, 1, 0)
model7 <- lm(formula = charges ~ age + bmi + children + bmi30*smoker + region, data = insurance2)
summary(model7)

#Transformasi logaritmik pada variabel charges
modeltransform2<- lm(log(charges) ~ age + bmi + children + sex + smoker + region, data = insurance2)
summary(modeltransform2)

#---------------------------------------------------------------
#Uji multikolinearitas dari setiap model
vif(model1)
vif(model2)
vif(model3)
vif(model4)
vif(model5)
vif(model6)
vif(model7)
vif(modeltransform)
vif(modeltransform2)

#--------------------------------------
#Uji asumsi normalitas pada residual, uji linearitas, dan uji homoskedastisitas pada setiap model
par(mfrow=c(1,1))
plot(model1)
plot(model2)
plot(model3)
plot(model4)
plot(model5)
plot(model6)
plot(model7)

#Uji asumsi model terbaik---------------------------------------
# 1. Uji Linearitas
gq_test <- gqtest(model3)
gq_test

#2. Uji Normalitas
residuals <- residuals(model3)
ks.test(model3$residuals,ecdf(model3$residuals))

#3. Uji Homoskedastisitas
bptest(model3)

#4. Uji Multikolinearitas antar variabel prediktor
vif(model3)
