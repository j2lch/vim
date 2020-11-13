all: requirements dotnet go
	
requirements:
	@echo "Creating home directories for vim..."
	@mkdir -p ~/.vim/pack/plugins/start
	@echo "copying .vimrc ..."
	@test -f ~/.vimrc || @ ln -s ~/.vim/vimrc.sample ~/.vimrc
	@echo "installing vim plugins"
	@git clone https://github.com/vim-airline/vim-airline ~/.vim/pack/dist/start/vim-airline
	@mkdir -p ~/.vim/pack/tpope/start
	@cd ~/.vim/pack/tpope/start
	@git clone https://tpope.io/vim/fugitive.git
	@vim -u NONE -c "helptags fugitive/doc" -c q
	@git clone https://github.com/vim-airline/vim-airline-themes ~/.vim/pack/dist/start/vim-airline-themes
	@git clone https://github.com/powerline/fonts.git --depth=1
	@cd fonts
	@./install.sh
	@cd ..
	@rm -rf fonts

go: requirements
	@echo "Installing vim-go plugin..."
	@git clone https://github.com/fatih/vim-go.git ~/.vim/pack/plugins/start/vim-go
	@echo 'let g:go_fmt_command = "goimports"' >> vimrc.sample
	@echo 'let g:go_auto_type_info = 1' >> vimrc.sample

dotnet:	requirements
	@echo "Installing Omnisharp-vim..."
	@git clone https://github.com/Omnisharp/omnisharp-vim.git ~/.vim/pack/plugins/start/omnisharp-vim

clean:
	@echo "cleaning environment"
	@rm ~/.vimrc
	@rm -rf ~/.vim/*

