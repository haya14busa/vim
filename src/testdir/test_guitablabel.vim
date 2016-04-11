if !has('gui_running')
  finish
endif

function! GuitablabelWithCaughtError()
  let s:func_in_guitablabel_called = 1
  try
    call eval('unknown expression')
  catch
  endtry
  return ''
endfunction

function! GuitablabelWithError()
  let s:func_in_guitablabel_called = 1
  call eval('unknown expression')
  return ''
endfunction

function! Test_caught_error_in_guitablabel()
  let s:func_in_guitablabel_called = 0
  " let guitablabel = '%{GuitablabelWithCaughtError()}'
  " let &guitablabel = guitablabel
  " set guitablabel=%{GuitablabelWithCaughtError()}
  set showtabline=2
  tabnew
  put='foooo'
  tabnew
  put='barrrr'
  new
  redraw!
  set tabline='footabline'
  echom &showtabline
  sleep 3
  redraw!
  " call assert_true(s:func_in_guitablabel_called)
  " call assert_equal(guitablabel, &guitablabel)
  set guitablabel=
endfunction

" function! Test_guitablabel_will_be_disabled_with_error()
"   let s:func_in_guitablabel_called = 0
"   set guioptions+=e
"   let guitablabel = '%{GuitablabelWithError()}'
"   try
"     let &guitablabel = guitablabel
"     redraw!
"   catch
"   endtry
"   call assert_true(s:func_in_guitablabel_called)
"   call assert_equal('', &guitablabel)
"   set guitablabel=
" endfunction

