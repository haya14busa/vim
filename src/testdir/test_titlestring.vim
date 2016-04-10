function! TitlestringWithCaughtError()
  let s:func_in_titlestring_called = 1
  try
    call eval('unknown expression')
  catch
  endtry
  return ''
endfunction

function! TitlestringWithError()
  let s:func_in_titlestring_called = 1
  call eval('unknown expression')
  return ''
endfunction

function! Test_caught_error_in_titlestring()
  let s:func_in_titlestring_called = 0
  let title_save = &title
  set title
  let titlestring = '%{TitlestringWithCaughtError()}'
  let &titlestring = titlestring
  redraw!
  call assert_true(s:func_in_titlestring_called)
  call assert_equal(titlestring, &titlestring)
  let &title = title_save
  set titlestring=
endfunction

function! Test_titlestring_will_be_disabled_with_error()
  let s:func_in_titlestring_called = 0
  let title_save = &title
  set title
  let titlestring = '%{TitlestringWithError()}'
  try
    let &titlestring = titlestring
    redraw!
  catch
  endtry
  call assert_true(s:func_in_titlestring_called)
  call assert_equal('', &titlestring)
  let &title = title_save
  set titlestring=
endfunction
