function! myspacevim#before() abort

    " note that autocmds should go here (I don't know why, but I followed the
    " discussions in this issue:
    " https://github.com/SpaceVim/SpaceVim/issues/1730)

    " Syntax highlighting for SCons files
    autocmd BufRead SConstruct set filetype=python
    autocmd BufRead SConscript set filetype=python

    " Syntax highlighting for Komascript files
    autocmd BufRead *.lco set filetype=tex
    autocmd BufRead *.lco set filetype=tex

    " autocmd BufRead ~/Science/FHDeX/*
    " \   let g:includes = '~/Science/amrex/build/dist-shared/include'
    " \ | let g:neomake_cpp_maker_args = [ '-I' . g:includes ]

    " better menus https://stackoverflow.com/a/526940
    set wildmode=longest,list,full
    set wildmenu

endfunction




function! myspacevim#after() abort

    filetype plugin indent on

    " Don't do this: I wan't to be able to use the 'repeat motion' action
    " " Less Shift-Key wear:
    " nmap ; :

    " show existing tab with 8 spaces width (compatibility with AMReX)
    set tabstop=8

    " when indenting with '>', use 4 spaces width
    set shiftwidth=4

    " on pressing tab, insert 4 spaces
    set expandtab

    " mark column 81
    set cc=81

    " use system clipboard
    set clipboard=unnamedplus


    " let g:cpp_std   = '-std=c++14 -I/usr/local/include/'
    let g:cpp_std   = '-std=c++11'
    let g:gcc_lib   = '-I/usr/local/Cellar/gcc/9.2.0_1/include/'
    " let g:clang_lib = '-isystem/usr/local/Cellar/llvm/9.0.0/include/' .
    " \ ' -isystem/Library/Developer/CommandLineTools/usr/include/'
    " let g:clang_lib = '-isystem/usr/local/Cellar/llvm/9.0.0/include/' . ' ' .
    "             \ '-isystem/usr/local/include' . ' ' .
    "             \ '-isystem/usr/local/Cellar/llvm/9.0.0/lib/clang/9.0.0/include/'
    let g:clang_lib = '-DAMREX_Darwin -DAMREX_FORT_USE_UNDERSCORE -DAMREX_PARTICLES -DAMREX_SPACEDIM=3 -DAMREX_USE_EB -DAMREX_USE_MPI -DBL_Darwin -DBL_FORT_USE_UNDERSCORE -DBL_SPACEDIM=3 -DBL_USE_MPI -Damrex_EXPORTS -I/Users/johannesblaschke/Science/amrex/Src/Base -I/Users/johannesblaschke/Science/amrex/Src/Boundary -I/Users/johannesblaschke/Science/amrex/Src/AmrCore -I/Users/johannesblaschke/Science/amrex/Src/Amr -I/Users/johannesblaschke/Science/amrex/Src/EB -I/Users/johannesblaschke/Science/amrex/Src/LinearSolvers/MLMG -I/Users/johannesblaschke/Science/amrex/Src/Particle -I/Users/johannesblaschke/Science/amrex/Src/Extern/amrdata -isystem /usr/local/Cellar/mpich/3.3.1/include  -O3 -DNDEBUG -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk -fPIC'

    let l:homedir = $HOME
    let g:base_dir = ''
    if isdirectory(l:homedir . '/Science')
        let g:base_dir = '-I' . l:homedir . '/Science/'
    endif


    let g:amrex_dir = 'amrex/build_nomp/dist-shared/include/'
    let g:fhdex_dor = 'FHDeX/'

    let g:cpp_clang_options =
                \   g:cpp_std  . " "
                \ . g:base_dir . g:amrex_dir


    let g:ale_cpp_clang_options      = g:cpp_clang_options . " " . g:clang_lib
    let g:ale_cpp_clangd_options     = g:cpp_clang_options . " " . g:clang_lib
    let g:ale_cpp_clangtidy_options  = g:cpp_clang_options . " " . g:clang_lib
    let g:ale_cpp_clangcheck_options = g:cpp_clang_options . " " . g:clang_lib
    let g:ale_cpp_gcc_options        = g:cpp_clang_options . " " . g:gcc_lib

endfunction
