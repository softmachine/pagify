SELECT "pagify_categories"."id", "pagify_categories"."name",
          "pagify_pages"."id", "pagify_pages"."name"
    FROM "pagify_categories"
            LEFT OUTER JOIN "pagify_categorizations" ON "pagify_categorizations"."category_id" = "pagify_categories"."id"
            LEFT OUTER JOIN "pagify_pages" ON "pagify_pages"."id" = "pagify_categorizations"."page_id"
    WHERE category_id NOT IN (SELECT category_id from pagify_categorizations WHERE page_id == 1) OR page_id IS NULL
