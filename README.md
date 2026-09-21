# 🎵 SoundStream Music Database

An enterprise-grade relational database schema designed for a modern music streaming platform (similar to Spotify or Apple Music). Built and evaluated as the Final Project for **CS50's Introduction to Databases with SQL (CS50 SQL)** at **Harvard University**.

![CS50 SQL Certified](https://img.shields.io/badge/CS50%20SQL-Certified-0052CC?style=for-the-badge&logo=harvard&logoColor=white)
![SQLite](https://img.shields.io/badge/SQLite-003B57?style=for-the-badge&logo=sqlite&logoColor=white)
[![Video Demo](https://img.shields.io/badge/YouTube-Video_Demo-FF0000?style=for-the-badge&logo=youtube&logoColor=white)](https://youtu.be/TcybBBd_ZHU)

---

## 📌 Overview

**SoundStream** is a scalable database backend built to support core operations of digital music streaming services. It handles user accounts, catalog hierarchies (artists, albums, and tracks), and personalized user content like custom playlists with high-performance query execution.

### 🎥 Project Walkthrough & Video Demo
Watch the full 3-minute video presentation explaining the architectural design and SQL implementation:  
👉 **[Watch SoundStream Demo on YouTube](https://youtu.be/TcybBBd_ZHU)**

---

## 🏗️ Architecture & Schema Design

The architecture comprises **6 interrelated entities** normalized to eliminate data redundancy and ensure transactional integrity:

| Entity / Table | Description | Key Fields |
| :--- | :--- | :--- |
| **`users`** | Listener profile and authentication data | `id` (PK), `username`, `email`, `joined_date` |
| **`artists`** | Creators and musicians catalog | `id` (PK), `name`, `genre` |
| **`albums`** | Musical releases associated with artists | `id` (PK), `title`, `artist_id` (FK), `release_year` |
| **`songs`** | Individual track metadata | `id` (PK), `title`, `album_id` (FK), `duration_seconds` |
| **`playlists`** | User-generated playlist containers | `id` (PK), `title`, `user_id` (FK), `created_at` |
| **`playlist_songs`** | **Junction Table** (Many-to-Many mapping) | `playlist_id` (FK), `song_id` (FK) -> *Composite Primary Key* |
```mermaid
erDiagram
    Artists ||--o{ Albums : "produces"
    Albums ||--o{ Songs : "contains"
    Users ||--o{ Playlists : "creates"
    Playlists ||--o{ Playlist_Songs : "includes"
    Songs ||--o{ Playlist_Songs : "appears in"
---

## ⚡ Key Features & Optimizations

- **Relational Integrity:** Implemented explicit Foreign Key constraints to maintain strict data integrity across all entities.
- **Search Optimization (Indexes):**
  - `song_title_index` on `songs(title)` to accelerate track lookups.
  - `artist_name_index` on `artists(name)` for quick artist discovery.
- **Complex Query Simplification (Views):**
  - `playlist_details`: A pre-compiled 6-table `JOIN` view that aggregates user details, playlist names, song titles, albums, and artist metadata into a single read-optimized structure.

---

## 🛠️ Usage & Quickstart

### Prerequisites
Make sure you have [SQLite3](https://www.sqlite.org/index.html) installed on your system.

### 1. Clone the Repository
```bash
git clone [https://github.com/T2004-la/soundstream-db.git](https://github.com/T2004-la/soundstream-db.git)
cd soundstream-db
2. Build the Schema
Initialize the database instance and build tables, indexes, and views:

Bash
sqlite3 soundstream.db < schema.sql
3. Run Sample Queries
Execute typical platform workflows (adding users, creating playlists, querying views):

Bash
sqlite3 soundstream.db < queries.sql
🎓 Verified Certificate
This project was developed by Tara Latifi as the capstone submission for CS50 SQL.
