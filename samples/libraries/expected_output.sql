SELECT
	------- LEVEL 1 -------
	json:lastUpdatedTimestamp::DATETIME AS lastUpdatedTimestamp,
	------- LEVEL 2 -------
	json:mostPopular:description::VARCHAR AS mostPopular_description,
	json:mostPopular:genre::VARCHAR AS mostPopular_genre,
	------- LEVEL 2 -------
	flatten_library.value:name::VARCHAR AS library_name,
	------- LEVEL 3 -------
	flatten_library.value:location:address::VARCHAR AS library_location_address,
	flatten_library.value:location:area::VARCHAR AS library_location_area,
	flatten_library.value:location:city::VARCHAR AS library_location_city,
	------- LEVEL 3 -------
	flatten_events.value:date::DATETIME AS library_events_date,
	flatten_events.value:description::VARCHAR AS library_events_description,
	flatten_events.value:name::VARCHAR AS library_events_name,
	------- LEVEL 3 -------
	flatten_section.value:name::VARCHAR AS library_section_name,
	------- LEVEL 3 -------
	json:mostPopular:book:author::VARCHAR AS mostPopular_book_author,
	json:mostPopular:book:rating::FLOAT AS mostPopular_book_rating,
	json:mostPopular:book:title::VARCHAR AS mostPopular_book_title,
	------- LEVEL 4 -------
	flatten_genre.value:name::VARCHAR AS section_genre_name,
	------- LEVEL 6 -------
	flatten_book.value:author::VARCHAR AS books_book_author,
	flatten_book.value:rating::FLOAT AS books_book_rating,
	flatten_book.value:tags::ARRAY AS books_book_tags,
	flatten_book.value:title::VARCHAR AS books_book_title,
	flatten_book.value:year::INTEGER AS books_book_year,
	------- LEVEL 7 -------
	flatten_book.value:shelfLocation:aisle::VARCHAR AS book_shelfLocation_aisle,
	flatten_book.value:shelfLocation:position::INTEGER AS book_shelfLocation_position,
	flatten_book.value:shelfLocation:row::INTEGER AS book_shelfLocation_row,
	------- LEVEL 8 -------
	flatten_chapter.value:title::VARCHAR AS chapters_chapter_title,
	flatten_chapter.value:pages::INTEGER AS chapters_chapter_pages,
FROM demo_table
	------- LEVEL 1 -------
	,LATERAL FLATTEN(INPUT => json:library, OUTER => TRUE) AS flatten_library
	------- LEVEL 2 -------
	,LATERAL FLATTEN(INPUT => flatten_library.value:section, OUTER => TRUE) AS flatten_section
	------- LEVEL 2 -------
	,LATERAL FLATTEN(INPUT => flatten_library.value:events, OUTER => TRUE) AS flatten_events
	------- LEVEL 3 -------
	,LATERAL FLATTEN(INPUT => flatten_section.value:genre, OUTER => TRUE) AS flatten_genre
	------- LEVEL 4 -------
	,LATERAL FLATTEN(INPUT => flatten_genre.value:books, OUTER => TRUE) AS flatten_books
	------- LEVEL 5 -------
	,LATERAL FLATTEN(INPUT => flatten_books.value:book, OUTER => TRUE) AS flatten_book
	------- LEVEL 6 -------
	,LATERAL FLATTEN(INPUT => flatten_book.value:chapters, OUTER => TRUE) AS flatten_chapters
	------- LEVEL 7 -------
	,LATERAL FLATTEN(INPUT => flatten_chapters.value:chapter, OUTER => TRUE) AS flatten_chapter
