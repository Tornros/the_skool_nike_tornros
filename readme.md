## 1. Introduktion

Välkommen! Jag har skapat en serie SQL-script som sorterar och svarar på frågor kring utbildningsdata tillhandahållen av MYH: Myndigheten för Yrkeshögskolan. [Länk till videopitch](https://youtu.be/L-koj5tpVZk).


## 2. GitHub-struktur

Alla SQL-script ligger direkt i repot. 

`admin/` innehåller bilder samt `05_old_q5_script.sql`, ett oanvänt script som användes i *Uppgift 1*.


## 3. Inledande förarbete

Innan scripten skapades skedde mindre uppstädning av datan. Då endast tabell 3 från "resultat-ansokningsomgang-2025" var nödvändig för denna uppgift, exporterades endast denna tabell. De första 6 raderna raderades även, då dessa ej innehöll någon relevant data. Se bild 1. 

![Bild 1](/admin/figures/bild_1.png)
*Bild 1*

Filen exporterades sedan som en .csv-fil, `tabell_3.csv`.


## 4. Repo filer & scriptfunktioner

`tabell_3.csv`, vår data, exporterad från "resultat-ansokningsomgang-2025".

`01_load_data.sql` laddar in datan och skapar tabellen "tabell3" i databasen baserat på vår .csv fil.

`02_basic_eda.sql` svarar på frågorna ställda i *Uppgift 1*.

`03_update_table.sql` används för att redigera tabeller. Skapades för att rätta till mindre stavfel. 

`04_data_driven_questions.sql` svarar på utökade EDA-frågor, *Uppgift 3*, baserat på en interju med The Skools representant, *Uppgift 2*. Se komplett lista över frågorna i kapitel 5.


## 5. Datadrivna beslut - Uppgift 3
Efter en intervju med The Skools representant formulerade jag följande fem frågor.

**Fråga 1:**
*Vilka områden är lägst belastade i respektive län?*

Motivering: Olika yrkesområden kan ha olika tung eller lätt belastning i länen. Ett tungt belastat område är svårare att bryta sig in i, då det redan finns en stor mängd etablerade utbildningar och utbildningsarnordnare. 


**Fråga 2:**
*Hur stor andel privata, jämfört med regionala och kommunala, utbildningsanordnare beviljas?*

Motivering: The Skool är en privat aktör, därför kan statistik kring i hur stor utsträckning privata aktörer, jämfört med regionala eller kommunala, får sina ansökta utbildningar beviljade. Om det finns områden där privata aktörer i högre grad får beviljade utbildningar är detta av intresse. 


**Fråga 3:**
*Vilken mängd omgångar är vanligast att söka? Vilken mängd omgångar blir oftast beviljade?*

Motivering: Utbildningar kan sökas i olika antal omgångar och för att det ska vara lönsamt att hålla en utbildning kör anordnare ofta mer än en omgång. Frågan undersöker hur många omgångar som generellt söks, samt i vilken utsträckning de blir beviljade. 


**Fråga 4:**
*Vilken SUN5-grupp är minst belastad?*

Motivering: Utbildningsområden delas vidare in i smalare SUN5-grupperingar. Där vissa områden är tungt belastade, kan det finns SUN5-grupper som är mindre belastade och i större utsträckning får godkännt eller är lättare att bryta sig in i. 


**Fråga 5:**
*Hur stor andel distansutbildningar blir beviljade jämfört med platsbundna, i de olika områdena?*

Motivering: The Skool är öppna för att utbilda både på plats och distans. Frågan undersöker om det finns mönster i om distans- eller platsbundna undervisningar i större eller lägre utsträckning får utbildningar beviljade. 
