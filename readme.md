## Introduktion

Välkommen! Jag har skapat en serie SQL-script som sorterar och svarar på frågor kring utbildningsdata tillhandahållen av MYH - Myndigheten för Yrkeshögskolan. Länk till videopitch[länk]

## GitHub-struktur

Alla SQL-script ligger direkt i repot. 

`admin` innehåller bilder samt `05_old_q5_script.sql`, ett oanvänt script som användes i Uppgift 1.

## 1. Inledande förarbete

Innan scripten skapas skedde mindre strukturering av datan. Då endast tabell 3 från "resultat-ansokningsomgang-2025" var nödvändig för denna uppgift, exporterades endast denna tabell. De första 6 raderna raderades även, då dessa ej innehöll någon relevant data. Se bild 1. 

![Bild 1](/admin/figures/bild_1.png)

*Bild 1*

Filen exporterades sedan som en .csv fil och importerades.

## 2. Repo filer & scriptfunktioner

`tabell_3.csv` vår data, exporterad från "resultat-ansokningsomgang-2025".

`01_load_data.sql` laddar in datan och skapar tabellen "tabell3" i databasen.

`02_basic_eda.sql` svarar på frågorna ställda i *Uppgift 1*.

`03_update_table.sql` används för att redigera tabeller. Skapades för att rätta till mindre stavfel. 

`04_data_driven_questions.sql` svarar på utökade EDA-frågor, baserat på interju med domänexpert under *Uppgift 2*. Se komplett lista i kapitel 3.

## 3. Datadrivna beslut - Uppgift 3

Fråga 1: 
Vilka områden är lägst belastade i respektive län?

Fråga 2:
Hur stor andel privata jämfört med regionala och kommunala utbildningsanordnare beviljas?

Fråga 3:
Hur många omgångar är vanligast att söka? Vilken mängd omgångar blir oftast beviljade?

Fråga 4:
Vilken SUN5-grupp är mins belastad?

Fråga 5:
Hur stor andel distansutbildningar blir beviljade jämfört med platsbundna, i de olika områdena?
