# REST API Plan

## 1. Resources
- **Users** - Managed by Supabase Auth
- **Flashcards** - Corresponds to the `flashcards` table
- **Generations** - Corresponds to the `generations` table
- **Generation Error Logs** - Corresponds to the `generation_error_logs` table

## 2. Endpoints

### 2.1 Authentication

#### Register
- **Method**: POST
- **Path**: `/auth/register`
- **Description**: Register a new user
- **Request Body**:
  ```json
  {
    "email": "string",
    "password": "string"
  }
  ```
- **Response**:
  ```json
  {
    "id": "uuid",
    "email": "string",
    "created_at": "timestamp"
  }
  ```
- **Success Codes**: 201 Created
- **Error Codes**: 400 Bad Request, 409 Conflict

#### Login
- **Method**: POST
- **Path**: `/auth/login`
- **Description**: Login with email and password
- **Request Body**:
  ```json
  {
    "email": "string",
    "password": "string"
  }
  ```
- **Response**:
  ```json
  {
    "access_token": "string",
    "token_type": "bearer",
    "expires_at": "timestamp",
    "user": {
      "id": "uuid",
      "email": "string"
    }
  }
  ```
- **Success Codes**: 200 OK
- **Error Codes**: 400 Bad Request, 401 Unauthorized

#### Logout
- **Method**: POST
- **Path**: `/auth/logout`
- **Description**: Logout the current user
- **Response**: No content
- **Success Codes**: 204 No Content
- **Error Codes**: 401 Unauthorized

### 2.2 Flashcards

#### List Flashcards
- **Method**: GET
- **Path**: `/flashcards`
- **Description**: Get all flashcards for the authenticated user
- **Query Parameters**:
  - `page`: integer (default: 1)
  - `limit`: integer (default: 20)
  - `sort_by`: string (default: 'created_at')
  - `sort_order`: string (default: 'desc')
  - `generation_id`: integer (optional)
- **Response**:
  ```json
  {
    "data": [
      {
        "id": "integer",
        "front": "string",
        "back": "string",
        "source": "string",
        "created_at": "timestamp",
        "updated_at": "timestamp",
        "generation_id": "integer",
        "user_id": "uuid"
      }
    ],
    "pagination": {
      "total": "integer",
      "pages": "integer",
      "page": "integer",
      "limit": "integer"
    }
  }
  ```
- **Success Codes**: 200 OK
- **Error Codes**: 401 Unauthorized, 500 Internal Server Error

#### Get Flashcard
- **Method**: GET
- **Path**: `/flashcards/:id`
- **Description**: Get a specific flashcard by ID
- **Response**:
  ```json
  {
    "id": "integer",
    "front": "string",
    "back": "string",
    "source": "string",
    "created_at": "timestamp",
    "updated_at": "timestamp",
    "generation_id": "integer",
    "user_id": "uuid"
  }
  ```
- **Success Codes**: 200 OK
- **Error Codes**: 401 Unauthorized, 404 Not Found

#### Create Flashcard
- **Method**: POST
- **Path**: `/flashcards`
- **Description**: Create a new flashcard manually
- **Request Body**:
  ```json
  {
    "front": "string",
    "back": "string",
    "source": "manual"
  }
  ```
- **Response**:
  ```json
  {
    "id": "integer",
    "front": "string",
    "back": "string",
    "source": "manual",
    "created_at": "timestamp",
    "updated_at": "timestamp",
    "user_id": "uuid"
  }
  ```
- **Success Codes**: 201 Created
- **Error Codes**: 400 Bad Request, 401 Unauthorized

#### Update Flashcard
- **Method**: PUT
- **Path**: `/flashcards/:id`
- **Description**: Update an existing flashcard
- **Request Body**:
  ```json
  {
    "front": "string",
    "back": "string"
  }
  ```
- **Response**:
  ```json
  {
    "id": "integer",
    "front": "string",
    "back": "string",
    "source": "string",
    "created_at": "timestamp",
    "updated_at": "timestamp",
    "generation_id": "integer",
    "user_id": "uuid"
  }
  ```
- **Success Codes**: 200 OK
- **Error Codes**: 400 Bad Request, 401 Unauthorized, 404 Not Found

#### Delete Flashcard
- **Method**: DELETE
- **Path**: `/flashcards/:id`
- **Description**: Delete a flashcard
- **Response**: No content
- **Success Codes**: 204 No Content
- **Error Codes**: 401 Unauthorized, 404 Not Found

### 2.3 AI Generation

#### Generate Flashcards
- **Method**: POST
- **Path**: `/generations`
- **Description**: Generate flashcards from a source text using AI
- **Request Body**:
  ```json
  {
    "source_text": "string",
    "count": "integer",
    "model": "string"
  }
  ```
- **Response**:
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
- **Success Codes**: 201 Created
- **Error Codes**: 400 Bad Request, 401 Unauthorized, 500 Internal Server Error

#### Get Generation
- **Method**: GET
- **Path**: `/generations/:id`
- **Description**: Get details about a specific generation
- **Response**:
  ```json
  {
    "id": "integer",
    "model": "string",
    "generated_count": "integer",
    "accepted_unedited_count": "integer",
    "accepted_edited_count": "integer",
    "source_text_hash": "string",
    "source_text_length": "integer",
    "generation_duration": "integer",
    "created_at": "timestamp",
    "updated_at": "timestamp",
    "user_id": "uuid"
  }
  ```
- **Success Codes**: 200 OK
- **Error Codes**: 401 Unauthorized, 404 Not Found

#### List Generations
- **Method**: GET
- **Path**: `/generations`
- **Description**: Get all generations for the authenticated user
- **Query Parameters**:
  - `page`: integer (default: 1)
  - `limit`: integer (default: 20)
  - `sort_by`: string (default: 'created_at')
  - `sort_order`: string (default: 'desc')
- **Response**:
  ```json
  {
    "data": [
      {
        "id": "integer",
        "model": "string",
        "generated_count": "integer",
        "accepted_unedited_count": "integer",
        "accepted_edited_count": "integer",
        "source_text_hash": "string",
        "source_text_length": "integer",
        "generation_duration": "integer",
        "created_at": "timestamp",
        "updated_at": "timestamp",
        "user_id": "uuid"
      }
    ],
    "pagination": {
      "total": "integer",
      "pages": "integer",
      "page": "integer",
      "limit": "integer"
    }
  }
  ```
- **Success Codes**: 200 OK
- **Error Codes**: 401 Unauthorized, 500 Internal Server Error

#### Accept Generated Flashcards
- **Method**: POST
- **Path**: `/generations/:id/accept`
- **Description**: Accept and save AI-generated flashcards
- **Request Body**:
  ```json
  {
    "flashcards": [
      {
        "id": "integer", 
        "front": "string",
        "back": "string",
        "accepted": "boolean",
        "edited": "boolean"
      }
    ]
  }
  ```
- **Response**:
  ```json
  {
    "accepted_count": "integer",
    "accepted_unedited_count": "integer",
    "accepted_edited_count": "integer"
  }
  ```
- **Success Codes**: 200 OK
- **Error Codes**: 400 Bad Request, 401 Unauthorized, 404 Not Found

### 2.4 Error Logs

#### List Error Logs
- **Method**: GET
- **Path**: `/error-logs`
- **Description**: Get all error logs for the authenticated user (admin only)
- **Query Parameters**:
  - `page`: integer (default: 1)
  - `limit`: integer (default: 20)
  - `sort_by`: string (default: 'created_at')
  - `sort_order`: string (default: 'desc')
- **Response**:
  ```json
  {
    "data": [
      {
        "id": "integer",
        "user_id": "uuid",
        "model": "string",
        "source_text_hash": "string",
        "source_text_length": "integer",
        "error_code": "string",
        "error_message": "string",
        "created_at": "timestamp"
      }
    ],
    "pagination": {
      "total": "integer",
      "pages": "integer",
      "page": "integer",
      "limit": "integer"
    }
  }
  ```
- **Success Codes**: 200 OK
- **Error Codes**: 401 Unauthorized, 403 Forbidden, 500 Internal Server Error

### 2.5 Spaced Repetition

#### Start Review Session
- **Method**: POST
- **Path**: `/reviews/start`
- **Description**: Start a new review session
- **Request Body**:
  ```json
  {
    "limit": "integer"
  }
  ```
- **Response**:
  ```json
  {
    "session_id": "string",
    "cards_count": "integer",
    "next_card": {
      "id": "integer",
      "front": "string"
    }
  }
  ```
- **Success Codes**: 200 OK
- **Error Codes**: 400 Bad Request, 401 Unauthorized

#### Get Next Card
- **Method**: GET
- **Path**: `/reviews/:session_id/next`
- **Description**: Get the next card in the review session
- **Response**:
  ```json
  {
    "id": "integer",
    "front": "string",
    "back": "string"
  }
  ```
- **Success Codes**: 200 OK
- **Error Codes**: 401 Unauthorized, 404 Not Found

#### Submit Card Review
- **Method**: POST
- **Path**: `/reviews/:session_id/submit`
- **Description**: Submit a review for a flashcard
- **Request Body**:
  ```json
  {
    "card_id": "integer",
    "score": "string" // "not_remembered", "hard", "good", "easy"
  }
  ```
- **Response**:
  ```json
  {
    "next_review_at": "timestamp",
    "next_card": {
      "id": "integer",
      "front": "string"
    }
  }
  ```
- **Success Codes**: 200 OK
- **Error Codes**: 400 Bad Request, 401 Unauthorized, 404 Not Found

#### End Review Session
- **Method**: POST
- **Path**: `/reviews/:session_id/end`
- **Description**: End the current review session
- **Response**:
  ```json
  {
    "stats": {
      "total_cards": "integer",
      "not_remembered": "integer",
      "hard": "integer",
      "good": "integer",
      "easy": "integer",
      "next_session_at": "timestamp"
    }
  }
  ```
- **Success Codes**: 200 OK
- **Error Codes**: 401 Unauthorized, 404 Not Found

## 3. Authentication and Authorization

The API will use Supabase Auth for authentication and authorization:

- JWT-based authentication with access tokens
- Automatic row-level security (RLS) policies on database tables
- Each authenticated request must include an Authorization header with a valid JWT token
- Access rules:
  - Users can only access their own flashcards, generations, and error logs
  - Admin-specific endpoints (like error-logs) require additional admin role verification

## 4. Validation and Business Logic

### 4.1 Validation Rules

#### Flashcards
- `front`: Required, string, max 200 characters
- `back`: Required, string, max 500 characters
- `source`: Required, enum ("ai-full", "ai-edited", "manual")

#### Generations
- `source_text`: Required, string, min 1000 characters, max 10000 characters
- `count`: Required, integer, min 1, max 50
- `model`: Required, string

### 4.2 Business Logic

- When generating flashcards:
  1. The system calculates a hash of the source text
  2. The system measures the time taken to generate flashcards
  3. The system tracks how many generated flashcards are accepted with/without edits
  4. Generated flashcards are initially marked as "ai-full"
  5. If a user edits a flashcard, it's marked as "ai-edited"
  
- When reviewing flashcards:
  1. The spaced repetition algorithm determines which flashcards to show
  2. User feedback (not_remembered, hard, good, easy) is recorded
  3. The algorithm updates the next review time for each flashcard
  4. The system provides statistics at the end of each review session 