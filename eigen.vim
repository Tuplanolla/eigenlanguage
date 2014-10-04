" Vim syntax file
" Language:     Eigenlanguage
" Maintainer:   Sampsa "Tuplanolla" Kiiskinen
" Version:      0.0.0

if exists("b:current_syntax")
	finish
endif

syntax case match

setlocal iskeyword=33-36,38-39,42-43,45-95,97-126

syntax keyword eigenTodo contained containedin=eigenLine TODO

" This parser should be treated with suspicion.

syntax match eigenCommentSymbol /%[^%`,()\[\]\t\n\v\f\r ]\+/
syntax match eigenPack /`/
syntax match eigenUnpack /,/
syntax match eigenOpen /(/
syntax match eigenClose /)/
syntax match eigenDualOpen /\[/
syntax match eigenDualClose /\]/
" syntax match eigenSymbol /[^%`,()\[\]\t\n\v\f\r ]\+/
syntax match eigenInteger /[+-]\?\d\+/
syntax match eigenNothing /()/
syntax match eigenFunction /->/
syntax match eigenBind /<-/
syntax match eigenModule /<->/

syntax region eigenCommentLine start=/% / end=/$/ oneline contains=eigenTodo
syntax region eigenCommentGroup start=/%(/ end=/)/ fold contains=eigenCommentGroup
syntax region eigenGroup start=/(/ end=/)/ fold contains=ALL
syntax region eigenDualGroup start=/\[/ end=/\]/ fold contains=ALL
syntax region eigenCharacter start=/[%`,()\[\]\t\n\v\f\r ]'/hs=s+1 skip=/\\./ end=/'/
syntax region eigenString start=/[%`,()\[\]\t\n\v\f\r ]"/hs=s+1 skip=/\\./ end=/"/

highlight link eigenTodo          Todo
highlight link eigenCommentLine   Comment
highlight link eigenCommentSymbol Comment
highlight link eigenCommentGroup  Comment
highlight link eigenOpen          Special
highlight link eigenClose         Special
highlight link eigenDualOpen      Structure
highlight link eigenDualClose     Structure
highlight link eigenPack          Structure
highlight link eigenUnpack        Structure
" highlight link eigenGroup         Special
" highlight link eigenSymbol        Identifier
highlight link eigenInteger       Number
highlight link eigenCharacter     Character
highlight link eigenString        String
highlight link eigenNothing       Constant
highlight link eigenFunction      Keyword
highlight link eigenBind          Keyword
highlight link eigenModule        Keyword

let b:current_syntax = "eigen"

" Indentation does not quite work, but this is close enough.

set lisp
set expandtab
set lispwords=
