# NewsApp-iOS

This project was built as part of an iOS developer assignment.

It demonstrates a clean, scalable implementation of a news reader app using UIKit and MVVM architecture.

---

## Features

### Top Headlines
- Fetch latest news using REST API
- Async/Await networking
- Infinite scrolling pagination

### Search
- API-based search
- Pagination reset on new query
- Empty state handling

### Bookmarks
- Save / unsave articles
- Local persistence
- Synced across tabs

### Image Loading
- Async image loading
- Placeholder handling
- Cell reuse safe

---

## Architecture

The app follows MVVM architecture:

- View → UIKit (Storyboard)
- ViewModel → Pagination, search, state
- Model → Codable API models
- Manager → Bookmark persistence

This keeps logic modular and maintainable.

---

## Tech Stack

- UIKit (Storyboard UI)
- Swift Concurrency (async/await)
- MVVM Architecture
- URLSession
- UITableView + Custom Cells

---

## Structure

Networking/
Models/
ViewModels/
ViewControllers/
Views/
Managers/
Extensions/


---

## Trade-offs

- Lightweight bookmark persistence for simplicity
- Minimal caching due to assignment scope
- Focus on clean architecture and scalability

---

## Future Improvements

- Image caching layer
- Unit testing (ViewModels)
- Offline support
- Diffable Data Source
- Deep linking

---

## Author

Rajni Dubey  
Senior iOS Developer  
6+ years experience building production mobile apps

---

## Notes

This project focus on:
- Clean code
- Separation of concerns
- Real-world architecture practices

