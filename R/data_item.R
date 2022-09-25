create_data_item <- function(item) {
  div(
    div(
      img(
        src = item$image,
        class = "item-image"
      )
    ),
    div(
      div(
        item$name,
        class = "item-name"
      ),
      div(
        item$species,
        class = "item-species"
      ),
      class = "item-main-info"
    ),
    class = "item"
  )
}

create_data_items <- function(data) {
  data_list <- purrr::transpose(data)
  lapply(data_list, create_data_item)
}
