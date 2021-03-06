#' Complete Stems
#' @param words character vector of words
#' @param stems character vector of stems
complete_stems <- function(words, stems){
  stem_word <- tibble::tibble(words = words, stems = stems) %>%
    dplyr::group_by(words) %>%
    dplyr::mutate(n_word = dplyr::n()) %>%
    dplyr::ungroup() %>%
    dplyr::group_by(stems) %>%
    dplyr::summarise(new_stems = dplyr::first(words, order_by = -n_word)) %>%
    dplyr::select(stems, new_stems)
  return(stem_word)
}

#' Extract words
#' Extracts all words from a character string of texts.
#' @param texts character vector of texts
#' @note it uses the regex \code{\\b[:alpha:]+\\b} to extract words.
extract_words <- function(texts){
  words <- tokenizers::tokenize_words(texts) %>%
    unlist() %>%
    unique()
  return(words)
}
