# Dokument wymagań produktu (PRD) - 10x Cards

## 1. Przegląd produktu

10x Cards to aplikacja webowa umożliwiająca szybkie i efektywne tworzenie wysokiej jakości fiszek edukacyjnych z wykorzystaniem sztucznej inteligencji. Produkt adresuje problem czasochłonnego procesu manualnego tworzenia fiszek, co często zniechęca użytkowników do korzystania z efektywnej metody nauki, jaką jest spaced repetition.

Kluczowe aspekty produktu:
- Generowanie fiszek przez AI na podstawie wprowadzonego tekstu (metodą kopiuj-wklej)
- Prosty i intuicyjny interfejs użytkownika
- Integracja z istniejącym algorytmem powtórek
- System kont użytkowników zapewniający prywatność danych
- Funkcjonalny prototyp dostarczony w ciągu 6 tygodni

10x Cards to proof-of-concept, mający na celu udowodnienie, że wykorzystanie AI może znacząco przyspieszyć i ułatwić proces tworzenia fiszek, zachowując przy tym ich wysoką jakość edukacyjną.

## 2. Problem użytkownika

Główny problem, który rozwiązuje 10x Cards:

Manualne tworzenie wysokiej jakości fiszek edukacyjnych jest czasochłonne, co zniechęca użytkowników do korzystania z efektywnej metody nauki, jaką jest spaced repetition. Ten problem manifestuje się poprzez:

1. Znaczny nakład czasu potrzebny do utworzenia zestawu fiszek o wysokiej wartości edukacyjnej
2. Trudność w przekształceniu surowych materiałów edukacyjnych w efektywne fiszki
3. Frustrację użytkowników, którzy wiedzą o skuteczności metody powtórek, ale rezygnują z niej ze względu na barierę wejścia
4. Nierównomierną jakość samodzielnie tworzonych fiszek, co wpływa na efektywność nauki

Użytkownik potrzebuje rozwiązania, które:
- Skróci czas tworzenia fiszek
- Zapewni wysoką jakość merytoryczną generowanych materiałów
- Będzie intuicyjne w obsłudze
- Umożliwi łatwe zarządzanie istniejącymi fiszkami
- Zintegruje proces tworzenia fiszek z algorytmem powtórek

## 3. Wymagania funkcjonalne

### 3.1 Generowanie fiszek przez AI
- System musi umożliwiać użytkownikowi wklejenie tekstu źródłowego
- System musi analizować tekst i automatycznie generować fiszki przy użyciu AI
- Użytkownik musi mieć możliwość wyboru liczby generowanych fiszek
- System powinien prezentować wygenerowane fiszki do akceptacji przed dodaniem ich do kolekcji użytkownika

### 3.2 Zarządzanie fiszkami
- System musi umożliwiać ręczne tworzenie fiszek (przód/tył)
- System musi zapewniać możliwość edycji istniejących fiszek
- System musi umożliwiać usuwanie fiszek
- System powinien pozwalać na organizowanie fiszek w zestawy tematyczne

### 3.3 System kont użytkowników
- System musi umożliwiać rejestrację nowych użytkowników
- System musi zapewniać bezpieczne logowanie
- System musi przechowywać fiszki przypisane do konta użytkownika
- System musi zapewniać podstawową prywatność danych użytkownika

### 3.4 Integracja z algorytmem powtórek
- System musi integrować się z istniejącym algorytmem powtórek bazującym na LLM
- System musi prezentować fiszki według harmonogramu ustalonego przez algorytm
- System musi rejestrować odpowiedzi użytkownika (poprawna/niepoprawna)
- System musi dostosowywać harmonogram powtórek na podstawie wyników użytkownika

### 3.5 Interfejs użytkownika
- Interfejs musi być prosty i intuicyjny
- Interfejs musi być responsywny i działać poprawnie w przeglądarkach internetowych
- Interfejs musi zapewniać jasne komunikaty o statusie operacji
- Interfejs musi umożliwiać płynną nawigację między funkcjami

## 4. Granice produktu

### 4.1 Co NIE wchodzi w zakres MVP
- Własny, zaawansowany algorytm powtórek (jak SuperMemo, Anki)
- Import wielu formatów plików (PDF, DOCX, itp.)
- Współdzielenie zestawów fiszek między użytkownikami
- Integracje z innymi platformami edukacyjnymi
- Aplikacje mobilne (na początek tylko wersja webowa)
- Statystyki i analizy użytkowania
- Funkcje monetyzacji (produkt będzie darmowy)

### 4.2 Ograniczenia techniczne
- Wykorzystanie serwisu OpenRouter do dostępu do LLM
- Brak optymalizacji pod kątem obsługi dużej liczby użytkowników
- Prosta architektura zorientowana na szybkie wdrożenie
- Tylko wersja webowa (brak aplikacji mobilnych)

### 4.3 Założenia biznesowe
- Produkt stanowi proof-of-concept, bez planów monetyzacji w fazie MVP
- Czas dostarczenia funkcjonalnego prototypu: 6 tygodni
- Produkt nie wymaga zaawansowanych integracji z systemami zewnętrznymi
- Produkt jest przeznaczony dla indywidualnych użytkowników, bez funkcji współpracy grupowej

## 5. Historyjki użytkowników

### Rejestracja i logowanie

#### US-001: Rejestracja nowego użytkownika
Jako nowy użytkownik, chcę utworzyć konto, aby móc korzystać z systemu fiszek.

Kryteria akceptacji:
- Formularz rejestracji zawiera pola: adres email, hasło, potwierdzenie hasła
- System weryfikuje poprawność formatu adresu email
- System wymaga hasła o minimalnej długości 8 znaków
- System sprawdza, czy adres email nie jest już zarejestrowany
- Po pomyślnej rejestracji, użytkownik otrzymuje potwierdzenie
- System przekierowuje nowego użytkownika do ekranu logowania

#### US-002: Logowanie do systemu
Jako zarejestrowany użytkownik, chcę zalogować się do systemu, aby uzyskać dostęp do moich fiszek.

Kryteria akceptacji:
- Formularz logowania zawiera pola: adres email i hasło
- System weryfikuje poprawność danych logowania
- W przypadku błędnych danych, system wyświetla odpowiedni komunikat
- Po pomyślnym logowaniu, użytkownik jest przekierowywany do głównego ekranu aplikacji
- System zapewnia opcję "Zapamiętaj mnie" dla wygody użytkownika


### Generowanie fiszek przez AI

#### US-003: Generowanie fiszek z tekstu źródłowego
Jako zalogowany użytkownik, chcę wkleić tekst źródłowy i wygenerować fiszki przy pomocy AI, aby zaoszczędzić czas.

Kryteria akceptacji:
- System udostępnia pole tekstowe do wklejenia materiału źródłowego
- Użytkownik może określić liczbę fiszek do wygenerowania (domyślnie 10)
- System wyświetla przycisk "Generuj fiszki"
- Po kliknięciu przycisku, system przetwarza tekst i generuje fiszki
- System informuje użytkownika o postępie generowania
- Wygenerowane fiszki są prezentowane użytkownikowi do przeglądu
- Każda fiszka zawiera przód (pytanie/pojęcie) i tył (odpowiedź/definicję)

#### US-004: Akceptowanie lub odrzucanie wygenerowanych fiszek
Jako użytkownik, chcę przejrzeć wygenerowane fiszki i zaakceptować lub odrzucić każdą z nich, aby zapewnić ich jakość.

Kryteria akceptacji:
- System prezentuje wygenerowane fiszki w formie listy lub karuzeli
- Przy każdej fiszce widoczne są przyciski "Akceptuj" i "Odrzuć"
- Użytkownik może edytować fiszki przed akceptacją
- System zapisuje tylko zaakceptowane fiszki do kolekcji użytkownika
- System informuje użytkownika o liczbie zaakceptowanych/odrzuconych fiszek
- System udostępnia przycisk "Zapisz wszystkie zaakceptowane" na końcu procesu

### Zarządzanie fiszkami

#### US-005: Ręczne tworzenie fiszek
Jako użytkownik, chcę ręcznie tworzyć nowe fiszki, aby dodać własne materiały edukacyjne.

Kryteria akceptacji:
- System udostępnia formularz z polami "Przód" i "Tył" dla nowej fiszki
- System zapewnia przycisk "Dodaj fiszkę"
- Po dodaniu, fiszka pojawia się w kolekcji użytkownika
- System potwierdza pomyślne dodanie fiszki
- Użytkownik może dodać więcej fiszek bez opuszczania ekranu

#### US-006: Przeglądanie kolekcji fiszek
Jako użytkownik, chcę przeglądać moje zapisane fiszki, aby sprawdzić ich zawartość.

Kryteria akceptacji:
- System wyświetla listę wszystkich fiszek użytkownika
- Fiszki są posortowane według daty utworzenia (od najnowszych)
- Każda fiszka na liście pokazuje fragment zawartości przodu
- Użytkownik może kliknąć na fiszkę, aby zobaczyć jej pełną zawartość
- System umożliwia przewijanie listy fiszek (paginację)
- System informuje, gdy kolekcja jest pusta

#### US-007: Edycja istniejących fiszek
Jako użytkownik, chcę edytować moje fiszki, aby poprawić błędy lub zaktualizować zawartość.

Kryteria akceptacji:
- Przy każdej fiszce dostępna jest opcja "Edytuj"
- System wyświetla formularz edycji z wypełnionymi aktualnymi danymi fiszki
- Użytkownik może zmienić zawartość przodu i tyłu fiszki
- System udostępnia przyciski "Zapisz zmiany" i "Anuluj"
- Po zapisaniu, fiszka jest aktualizowana w kolekcji
- System potwierdza pomyślną aktualizację fiszki

#### US-008: Usuwanie fiszek
Jako użytkownik, chcę usuwać niepotrzebne fiszki z mojej kolekcji, aby utrzymać porządek.

Kryteria akceptacji:
- Przy każdej fiszce dostępna jest opcja "Usuń"
- System wyświetla prośbę o potwierdzenie przed usunięciem
- Po potwierdzeniu, fiszka jest usuwana z kolekcji
- System potwierdza pomyślne usunięcie fiszki
- Operacja usunięcia jest nieodwracalna

### System powtórek

#### US-009: Rozpoczęcie sesji powtórek
Jako użytkownik, chcę rozpocząć sesję powtórek, aby uczyć się moich fiszek.

Kryteria akceptacji:
- System udostępnia przycisk "Rozpocznij powtórki" na głównym ekranie
- Użytkownik może wybrać konkretny zestaw do powtórek lub wszystkie fiszki
- System wybiera fiszki do powtórzenia zgodnie z algorytmem
- System wyświetla pierwszą fiszkę z przodu, ukrywając odpowiedź
- Użytkownik ma możliwość określenia limitu fiszek w sesji (domyślnie 20)
- System informuje o liczbie fiszek w bieżącej sesji

#### US-010: Ocenianie odpowiedzi podczas powtórek
Jako użytkownik, chcę oceniać moje odpowiedzi podczas powtórek, aby system mógł dostosować harmonogram.

Kryteria akceptacji:
- Po wyświetleniu przodu fiszki, system udostępnia przycisk "Pokaż odpowiedź"
- Po pokazaniu odpowiedzi, system wyświetla przyciski oceny: "Nie pamiętałem", "Trudne", "Dobre", "Łatwe"
- System rejestruje ocenę użytkownika
- Algorytm dostosowuje harmonogram powtórek na podstawie oceny
- System przechodzi do następnej fiszki po ocenie
- Użytkownik może przerwać sesję w dowolnym momencie

#### US-011: Podsumowanie sesji powtórek
Jako użytkownik, chcę zobaczyć podsumowanie po zakończeniu sesji powtórek, aby śledzić moje postępy.

Kryteria akceptacji:
- Po ostatniej fiszce w sesji, system wyświetla ekran podsumowania
- Podsumowanie zawiera liczbę przerobionjych fiszek
- Podsumowanie zawiera statystyki odpowiedzi (ile łatwych, dobrych, trudnych, niepamiętanych)
- System informuje, kiedy odbędzie się następna sesja powtórek
- System udostępnia przycisk "Powrót do głównego ekranu"

### Inne funkcjonalności

#### US-012: Wylogowanie z systemu
Jako zalogowany użytkownik, chcę się wylogować z systemu, aby zabezpieczyć moje konto.

Kryteria akceptacji:
- System udostępnia opcję "Wyloguj" w menu użytkownika
- Po wylogowaniu, użytkownik jest przekierowywany do ekranu logowania
- System usuwa lokalne tokeny uwierzytelniające
- Wylogowany użytkownik nie ma dostępu do zasobów wymagających autoryzacji


## 6. Metryki sukcesu

### 6.1 Metryki produktowe

- 75% fiszek wygenerowanych przez AI jest akceptowane przez użytkownika (bez edycji)
- Użytkownicy tworzą 75% swoich fiszek z wykorzystaniem funkcji AI
- Średni czas tworzenia zestawu 10 fiszek jest krótszy niż 5 minut
- 70% użytkowników korzysta z systemu powtórek co najmniej raz w tygodniu
- 60% użytkowników wraca do aplikacji po tygodniu od pierwszego użycia

### 6.2 Metryki techniczne

- Czas odpowiedzi API dla generowania fiszek: maksymalnie 10 sekund dla zestawu 10 fiszek
- Dostępność systemu: 99% czasu
- Średni czas ładowania strony: poniżej 2 sekundy
- Wskaźnik błędów systemu: poniżej 1%

### 6.3 Wskaźniki biznesowe

- Dostarczenie funkcjonalnego prototypu w ciągu 6 tygodni
- Koszt utrzymania infrastruktury poniżej założonego budżetu
- Pozytywne opinie od minimum 70% testerów
- Przynajmniej 3 potencjalne ścieżki rozwoju produktu zidentyfikowane na podstawie feedbacku użytkowników 