# API Endpoint Implementation Plan: Generate Flashcards

## 1. Przegląd punktu końcowego
Endpoint "Generate Flashcards" służy do generowania fiszek na podstawie dostarczonego tekstu źródłowego przy użyciu sztucznej inteligencji. Endpoint tworzy nowy rekord generacji, inicjuje proces generowania fiszek przez AI, śledzi metryki wydajności i zwraca wygenerowane fiszki użytkownikowi.

## 2. Szczegóły żądania
- **Metoda HTTP**: POST
- **Struktura URL**: `/generations`
- **Parametry**:
  - **Wymagane**: Brak parametrów URL
  - **Opcjonalne**: Brak parametrów URL
- **Request Body**:
  ```json
  {
    "source_text": "string", // Min 1000, max 10000 znaków
    "count": "integer", // Min 1, max 50
    "model": "string" // Nazwa modelu AI do użycia
  }
  ```
- **Nagłówki**:
  - `Authorization`: Bearer token (JWT)

## 3. Wykorzystywane typy
```typescript
// DTOs
interface GenerateFlashcardsRequestDto {
  source_text: string;
  count: number;
  model: string;
}

interface FlashcardDto {
  id: number;
  front: string;
  back: string;
  source: string;
}

interface GenerateFlashcardsResponseDto {
  generation_id: number;
  flashcards: FlashcardDto[];
}

// Command Models
interface GenerateFlashcardsCommand {
  userId: string;
  sourceText: string;
  count: number;
  model: string;
}

// Entities
interface Generation {
  id: number;
  user_id: string;
  model: string;
  generated_count: number;
  accepted_unedited_count: number;
  accepted_edited_count: number;
  source_text_hash: string;
  source_text_length: number;
  generation_duration: number;
  created_at: Date;
  updated_at: Date;
}

interface Flashcard {
  id: number;
  front: string;
  back: string;
  source: string;
  created_at: Date;
  updated_at: Date;
  generation_id: number;
  user_id: string;
}

interface GenerationErrorLog {
  id: number;
  user_id: string;
  model: string;
  source_text_hash: string;
  source_text_length: number;
  error_code: string;
  error_message: string;
  created_at: Date;
}
```

## 4. Szczegóły odpowiedzi
- **Sukces (201 Created)**:
  ```json
  {
    "generation_id": "integer",
    "flashcards": [
      {
        "id": "integer",
        "front": "string",
        "back": "string",
        "source": "ai-full"
      }
    ]
  }
  ```
- **Kody błędów**:
  - 400 Bad Request - Nieprawidłowe parametry wejściowe
  - 401 Unauthorized - Brak uwierzytelnienia
  - 500 Internal Server Error - Błąd serwera lub usługi AI

## 5. Przepływ danych
1. **Odebranie żądania**:
   - Aplikacja otrzymuje żądanie POST z danymi wejściowymi (tekst źródłowy, liczba fiszek, model AI)
   - Middleware uwierzytelniania weryfikuje token JWT i identyfikuje użytkownika

2. **Walidacja danych wejściowych**:
   - Sprawdzenie wymaganych pól
   - Walidacja długości tekstu źródłowego (min 1000, max 10000 znaków)
   - Walidacja liczby fiszek (min 1, max 50)
   - Sprawdzenie dostępności modelu AI

3. **Przetwarzanie w usłudze**:
   - Obliczenie skrótu tekstu źródłowego (hash)
   - Zapis informacji o generacji w tabeli `generations`
   - Rozpoczęcie pomiaru czasu generacji
   - Wywołanie usługi AI z tekstem źródłowym
   - Końcowy pomiar czasu generacji
   - Aktualizacja rekordu generacji z informacjami o czasie
   - Przygotowanie odpowiedzi dla klienta

4. **Zapisywanie danych**:
   - Zapisanie wygenerowanych fiszek w tabeli `flashcards`
   - Przypisanie każdej fiszki do bieżącej generacji i użytkownika
   - Ustawienie źródła fiszki jako "ai-full"

5. **Zwrócenie odpowiedzi**:
   - Zwrócenie ID generacji i listy wygenerowanych fiszek klientowi

## 6. Względy bezpieczeństwa
1. **Uwierzytelnianie**:
   - Każde żądanie musi zawierać token JWT w nagłówku Authorization
   - Sprawdzenie ważności tokenu przez middleware

2. **Autoryzacja**:
   - Użytkownik może generować fiszki tylko dla siebie
   - Implementacja RLS (Row-Level Security) w Supabase dla tabeli `generations`

3. **Walidacja danych wejściowych**:
   - Sanityzacja tekstu źródłowego przed przekazaniem do usługi AI
   - Sprawdzenie limitów długości tekstu i liczby generowanych fiszek

4. **Ograniczenia zasobów**:
   - Implementacja limitowania szybkości (rate limiting) dla ograniczenia liczby wywołań AI
   - Monitorowanie zużycia zasobów AI

## 7. Obsługa błędów
1. **Błędy walidacji (400 Bad Request)**:
   - Nieprawidłowa długość tekstu źródłowego
   - Nieprawidłowa liczba fiszek
   - Nieobsługiwany model AI

2. **Błędy uwierzytelniania (401 Unauthorized)**:
   - Brak tokenu JWT
   - Wygasły token JWT
   - Nieprawidłowy token JWT

3. **Błędy autoryzacji (403 Forbidden)**:
   - Próba dostępu do zasobów innego użytkownika

4. **Błędy usługi AI (500 Internal Server Error)**:
   - Awaria usługi AI
   - Timeout podczas przetwarzania
   - Błędy związane z limitem zasobów

5. **Rejestrowanie błędów**:
   - Zapis błędów generacji w tabeli `generation_error_logs`
   - Rejestrowanie metryk błędów dla monitorowania

## 8. Rozważania dotyczące wydajności
1. **Optymalizacja zapytań**:
   - Efektywne operacje bazy danych z indeksami dla szybkiego wyszukiwania
   - Zoptymalizowane zapytania do tabeli `generations` i `flashcards`

2. **Obsługa długotrwałych operacji**:
   - Operacje AI mogą być długotrwałe - rozważenie asynchronicznego przetwarzania
   - Implementacja powiadamiania klienta o zakończeniu generacji (opcjonalnie)

3. **Buforowanie**:
   - Buforowanie podobnych żądań - sprawdzanie hash tekstu pod kątem wcześniejszych generacji

4. **Monitorowanie wydajności**:
   - Śledzenie czasu generacji i rejestrowanie metryk
   - Śledzenie obciążenia zasobów AI

## 9. Etapy wdrożenia
1. **Konfiguracja struktury API**:
   - Utworzenie endpointu Astro `/pages/api/generations.ts`
   - Zaimplementowanie obsługi metody POST

2. **Implementacja walidacji**:
   - Utworzenie schematu walidacji dla danych wejściowych
   - Implementacja middleware walidacji

3. **Implementacja usług**:
   - Utworzenie `src/lib/services/ai-generation.service.ts` do obsługi logiki generacji
   - Implementacja logiki biznesowej, w tym obliczanie hash, pomiar czasu, interakcja z AI

4. **Integracja z bazą danych**:
   - Konfiguracja klienta Supabase w `src/db/generations.ts`
   - Implementacja operacji CRUD dla generacji i fiszek

5. **Obsługa błędów**:
   - Implementacja mechanizmu rejestrowania błędów generacji
   - Konfiguracja odpowiednich kodów statusu i komunikatów

6. **Zabezpieczenie endpointu**:
   - Implementacja middleware uwierzytelniania
   - Konfiguracja RLS w Supabase

7. **Testowanie**:
   - Testowanie jednostkowe komponentów usługi
   - Testowanie integracyjne całego przepływu API
   - Testowanie wydajności przy różnych rozmiarach tekstu źródłowego

8. **Dokumentacja**:
   - Aktualizacja dokumentacji API
   - Dodanie przykładów użycia i odpowiedzi 