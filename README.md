# Opdracht Proof-of-concept geautomatiseerde data workflow
## 1 Setup [setup.sh](./setup.sh)
De setup word behandeld door setup.sh 
*  Dit script zorcht er voor dat de nodige packages aanwezig zijn
*  Het kijkt na of de folders aanwezig zijn en maakt en indien niet kan de gebruiker kiezn om deze aan te maken
*  Het script zal dan cronjobs aanmaken voor ruwe data te gaan halen [get_data.sh](./get_data.sh) en voor deze data te verwerken [runtime.sh](./runtime.sh)
voor meer info over de verschilende opties te krijgen kan men -h of --help gebruiken als optie mee te geven naar setup.sh

## 2 Ruwe data verzamelen [get_data.sh](./get_data.sh)
Deze stap zal elke 12uur opnieuw data verzamelen en deze opslagen.
Er is voor 12uur gekozen omdat de data dat de api terug geeft maar 2 keer per dag update

## 3 Data verwerken [runtime.sh](./runtime.sh)
Deze file zal elke 24uur de ruwe data verwerken tot clean data [clean_data.sh](./clean_data.sh) en zal dan deze data analyseren en verwerken tot een raport [analyse_and_report_gen.py](./analyse_and_report_gen.py) 

