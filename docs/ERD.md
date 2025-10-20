# ER図（ととのいmatch!!）

```mermaid
erDiagram

    USERS ||--o{ REVIEWS : "has many"
    USERS ||--o{ FAVORITES : "has many"
    USERS ||--o{ RESULTS : "has many"

    SAUNAS ||--o{ REVIEWS : "has many"
    SAUNAS ||--o{ FAVORITES : "has many"
    SAUNA_TYPES ||--o{ SAUNAS : "has many"
    SAUNA_TYPES ||--o{ ANSWERS : "has many"

    QUESTIONS ||--o{ ANSWERS : "has many"
    ADMINS ||--o{ SAUNA_TYPES : "has many"

    USERS {
        int id PK
        string name
        string email
        string password_digest
        date created_at
        date updated_at
    }

    ADMINS {
        int id PK
        string email
        string password_digest
        date created_at
        date updated_at
    }

    SAUNAS {
        int id PK
        string name
        string location
        text description
        int temperature
        string image_url
        int sauna_type_id FK
        date created_at
        date updated_at
    }

    REVIEWS {
        int id PK
        int user_id FK
        int sauna_id FK
        int rating
        text content
        date created_at
        date updated_at
    }

    FAVORITES {
        int id PK
        int user_id FK
        int sauna_id FK
        date created_at
        date updated_at
    }

    SAUNA_TYPES {
        int id PK
        string name
        text description
        date created_at
        date updated_at
    }

    QUESTIONS {
        int id PK
        text content
        date created_at
        date updated_at
    }

    ANSWERS {
        int id PK
        string content
        int question_id FK
        int sauna_type_id FK
        date created_at
        date updated_at
    }

    RESULTS {
        int id PK
        int user_id FK
        int sauna_type_id FK
        date created_at
        date updated_at
    }
