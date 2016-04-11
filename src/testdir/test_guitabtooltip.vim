if !has('gui_running')
  finish
endif

function! GuitabtooltipWithCaughtError()
  let s:func_in_guitabtooltip_called = 1
  try
    call eval('unknown expression')
  catch
  endtry
  return ''
endfunction

function! GuitabtooltipWithError()
  let s:func_in_guitabtooltip_called = 1
  call eval('unknown expression')
  return ''
endfunction

function! Test_caught_error_in_guitabtooltip()
  let s:func_in_guitabtooltip_called = 0
  set showtabline=2
  set guioptions+=e
  let guitabtooltip = '%{GuitabtooltipWithCaughtError()}'
  let &guitabtooltip = guitabtooltip
  redraw!
  call assert_true(s:func_in_guitabtooltip_called)
  call assert_equal(guitabtooltip, &guitabtooltip)
  set guitabtooltip=
endfunction

function! Test_guitabtooltip_will_be_disabled_with_error()
  let s:func_in_guitabtooltip_called = 0
  set showtabline=2
  set guioptions+=e
  let guitabtooltip = '%{GuitabtooltipWithError()}'
  try
    let &guitabtooltip = guitabtooltip
    redraw!
  catch
  endtry
  call assert_true(s:func_in_guitabtooltip_called)
  call assert_equal('', &guitabtooltip)
  set guitabtooltip=
endfunction

