# ER図（ととのいmatch!!）

```mermaid
erDiagram

  USERS {
    int id PK
    string name
    string email
    string encrypted_password
    datetime created_at
    datetime updated_at
  }

  ADMINS {
    int id PK
    string email
    string encrypted_password
    datetime created_at
    datetime updated_at
  }

  SAUNA_TYPES {
    int id PK
    string name
    text description
    datetime created_at
    datetime updated_at
  }

  SAUNAS {
    int id PK
    string name
    text description
    integer price
    string location
    float latitude
    float longitude
    integer temperature
    string image_url
    time open_time
    time close_time
    boolean has_outdoor_bath
    int sauna_type_id FK
    datetime created_at
    datetime updated_at
  }

  RESULTS {
    int id PK
    int user_id FK
    int sauna_type_id FK
    json answers
    datetime created_at
    datetime updated_at
  }

  QUESTIONS {
    int id PK
    string content
    datetime created_at
    datetime updated_at
  }

  ANSWERS {
    int id PK
    int question_id FK
    string content
    datetime created_at
    datetime updated_at
  }

  DIAGNOSIS_ANSWERS {
    int id PK
    int result_id FK
    int answer_id FK
    datetime created_at
    datetime updated_at
  }

  REVIEWS {
    int id PK
    int user_id FK
    int sauna_id FK
    int rating
    text comment
    datetime created_at
    datetime updated_at
  }

  FAVORITES {
    int id PK
    int user_id FK
    int sauna_id FK
    datetime created_at
    datetime updated_at
  }

  %% リレーション定義
  USERS ||--o{ RESULTS : "has_many"
  USERS ||--o{ REVIEWS : "writes"
  USERS ||--o{ FAVORITES : "favorites"
  SAUNA_TYPES ||--o{ RESULTS : "has_many"
  SAUNA_TYPES ||--o{ SAUNAS : "recommended"
  RESULTS ||--o{ DIAGNOSIS_ANSWERS : "has_many"
  QUESTIONS ||--o{ ANSWERS : "has_many"
  ANSWERS ||--o{ DIAGNOSIS_ANSWERS : "has_many"
  SAUNAS ||--o{ REVIEWS : "has_many"
  SAUNAS ||--o{ FAVORITES : "favorited_by"
