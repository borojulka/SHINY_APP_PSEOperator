# SHINY_APP_PSEOperator
Aplikacja Shiny prezentującą dane energetyczne publikowane przez PSE Operatora.
Dane o wykonaniu (pv, wiatr, magazyny energii i zapotrzebowanie): 
https://raporty.pse.pl/index.html?report=HIS-WLK-CAL&state=Funkcjonowanie%20KSE,Raporty%20dobowe%20z%20funkcjonowania%20KSE&date=2024-12-18&type=table&search=&
Dane o cenach:
https://raporty.pse.pl/index.html?report=CRB-ROZL&state=Funkcjonowanie%20RB,Raporty%20dobowe%20z%20funkcjonowania%20RB,Podstawowe%20wska%C5%BAniki%20cenowe%20i%20kosztowe&date=2024-11-30&type=table&search=&
Pobieranie danych zrealizowane jest w utils.r.
Aplikacja:
1. Umożliwia wybór danych do przeglądania (ceny/pv/wiatr/magazyny/zapotrzebowanie);
2. Umożliwia wybór okresu przeglądania danych (nie wcześniej niż 2024-06-14 i nie później niż obecna data systemowa);
3. Umożliwia aktualizację danych;
4. Prezentuje wybrane dane w formie tabelarycznej, przy założeniu, że tabela będzie interaktywna (DT); aplikacja ma zawierać jedną tabelę, w której będą prezentowane wybrane dane;
5. Wizualizuje wybrane dane w postaci szeregów czasowych w sposób interaktywny (plotly); aplikacja ma zawierać zakładkę z wykresem liniowym, na której będą prezentowane wybrane dane;
6. Wizualizuje wybrane dane w dowolny, co najmniej jeden inny sposób niż w postaci szeregów czasowych;

Do realizacji projektu wykorzystano pakiety: shiny, plotly, bslib, DT, data.table
