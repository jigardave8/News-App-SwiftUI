# News-App-SwiftUI

Home View:

Displays a list of news articles.
Allows searching for news articles based on keywords.

News List:

Displays news articles with their titles, descriptions, images (if available), source, and published date.
Supports pagination with a "Load More" feature.

News Detail View:

Shows detailed information about a selected news article.
Displays the article's title, description, image (if available), source, and published date.

Refresh Feature:

Implements a refresh button in the navigation bar to fetch the latest news.
Displays a loading indicator while refreshing.

Search Functionality:

Provides a search bar for users to search for news articles based on keywords.
Filters news articles based on the search query in real-time.
Allows users to perform a new search by tapping a "Search" button.

UI Polish:

Utilizes SwiftUI components for a clean and modern UI.
Uses the SDWebImageSwiftUI library for asynchronous loading of images.

Pagination:

Implements a paginated approach for fetching and displaying news articles.

Error Handling:

Prints error messages to the console if there are issues with data fetching.

Code Organization:

Defines a clear structure with separate views for Home, News Detail, and News Row.
Encapsulates API-related logic within the GetNewsData class.

Comments:

Includes comments in the code for better readability and understanding.
