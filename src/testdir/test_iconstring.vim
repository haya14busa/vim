function! IconstringWithCaughtError()
  let s:func_in_iconstring_called = 1
  try
    call eval('unknown expression')
  catch
  endtry
  return ''
endfunction

function! IconstringWithError()
  let s:func_in_iconstring_called = 1
  call eval('unknown expression')
  return ''
endfunction

function! Test_caught_error_in_iconstring()
  let s:func_in_iconstring_called = 0
  let icon_save = &icon
  set icon
  let iconstring = '%{IconstringWithCaughtError()}'
  let &iconstring = iconstring
  redraw!
  call assert_true(s:func_in_iconstring_called)
  call assert_equal(iconstring, &iconstring)
  let &icon = icon_save
  set iconstring=
endfunction

function! Test_statusline_will_be_disabled_with_error()
  let s:func_in_statusline_called = 0
  let icon_save = &icon
  set icon
  let statusline = '%{IconstringWithError()}'
  try
    let &iconstring = iconstring
    redraw!
  catch
  endtry
  call assert_true(s:func_in_iconstring_called)
  call assert_equal('', &iconstring)
  let &icon = icon_save
  set iconstring=
endfunction
