\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{../../cours}[2019/01/09 LaTeX class for Lessons]
\makeatletter
% Base Class

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}


% Custom arguments
\def\teacher#1{\gdef\@teacher{#1}}
\def\module#1{\gdef\@module{#1}}

\ProcessOptions\relax
% Main packages

\LoadClass[12pt,a4paper,french,titlepage]{book}

\RequirePackage[french]{babel} % pour ecrire en francais
\RequirePackage[left=2.00cm, right=2.00cm, top=3.00cm, bottom=3.00cm,headheight=15pt]{geometry} % la mise en page

% Packages
\RequirePackage[utf8]{inputenc} % encodage
\RequirePackage[T1]{fontenc}
\RequirePackage{fancyhdr} % la mise en page
\RequirePackage[dvipsnames,x11names]{xcolor} % Un peu de couleur !
\RequirePackage{float}
\RequirePackage{listings}
\RequirePackage{subcaption}
\RequirePackage{multicol}
\RequirePackage{subfiles}
\RequirePackage{hyperref}
\hypersetup{
    unicode=true,            % non-Latin characters in Acrobat’s bookmarks
    pdftoolbar=true,         % show Acrobat’s toolbar?
    pdfmenubar=true,         % show Acrobat’s menu?
    pdffitwindow=false,      % window fit to page when opened
    pdfstartview={FitH},     % fits the width of the page to the window
    pdftitle=\@title,      % title
    pdfauthor=\@author,    % author
    colorlinks=true,         % false: boxed links; true: colored links
    linkcolor=black,      % color of internal links
    citecolor=OliveGreen,    % color of links to bibliography
    filecolor=magenta,       % color of file links
    urlcolor=BlueViolet      % color of external links
}
\RequirePackage{tikz}
\usetikzlibrary{fit}
\usetikzlibrary{positioning}
\RequirePackage{schemabloc} 
\RequirePackage[european,cuteinductors,siunitx,straightvoltages]{circuitikz}
\tikzset{every picture/.style={execute at begin picture={\shorthandoff{:;!?};}}}
\usetikzlibrary{positioning, fit, calc}
\RequirePackage{pgfplots}
\RequirePackage{mathtools}
\RequirePackage{amsfonts}
\RequirePackage{mathrsfs}
\RequirePackage{amssymb}
\RequirePackage[section]{placeins} % Oblige a placer toutes les figures avant de passer a la section suivante

\RequirePackage{fancyhdr}
\pagestyle{fancy}
  \fancyhf {}


\renewcommand{\chaptermark}[1]{\markboth{\bsc{\@chapapp~\thechapter{}~:} #1}{}}

  \renewcommand{\sectionmark}[1]{\markright{\thesection.{} #1}}
  \renewcommand{\headrulewidth}{1pt}   %Epaisseur de la ligne.
  \renewcommand{\footrulewidth}{1pt}   %Epaisseur de la ligne.
  \fancyhead[LE]{\textsl{\leftmark}}
  \fancyhead[LO]{{}}
  \fancyhead[RO]{\textsl{\rightmark}}
  \fancyhead[RE]{{}}
  \fancyfoot[C]{\textit{\thepage}}
  \fancyfoot[L]{\textsl{\@module}}
  \fancyfoot[R]{M1 IST-E3A}

\definecolor{mygreen}{RGB}{28,172,0} % color values Red, Green, Blue
\definecolor{mylilas}{RGB}{170,55,241}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%% Custom title Page %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{setspace}
\renewcommand{\maketitle}{%
  \begin{titlepage}
    \centering
    \vspace*{-2cm}
    \includegraphics[width=\linewidth]{../../img/bandeau-master-e3a}\\
    \vspace{1cm}
		{\huge \textsc{M1 E3A - Voie André Ampère}}
		\vspace{1cm}
        % \includegraphics[height=4cm]{Saphire} \\
        \vfill
        \@ifundefined{@module}
        {}
        {%
          \baselineskip=2\baselineskip
          {\Huge \textbf{\textsc{\@module}}}\\
          %\baselineskip=0.5\baselineskip
        }\vfill
        \@ifundefined{@title}
        {}
        {%
          \baselineskip=2\baselineskip
          {\Huge \textbf{\textsc{\@title}}}\\
          \baselineskip=0.5\baselineskip
        }\vfill
      \@ifundefined{@author}
        {}{%
          {\Large
            \begin{minipage}[t]{0.5\linewidth}
              \raggedright
              \underline{Enseignant:} \\
              \textsc{\@teacher}
            \end{minipage}\hfill
            \begin{minipage}[t]{0.5\linewidth}
              \raggedleft
              \underline{Rédigé par:} \\
              \textsc{\@author}
            \end{minipage}
          }}\\
    \vspace{1cm}
	\includegraphics[width=6cm]{../../img/ENSPS}
	\hfill
	\includegraphics[width=6cm]{../../img/UPS}\\
	\vspace{0.5cm}
	\includegraphics[width=\linewidth]{../../img/bandeau-eea}
	\end{titlepage}}

% pas de début de section dans la moitié inférieure d'une page

  \RequirePackage{needspace}

%  \renewcommand{\section}{
    % \needspace{0.2\textheight}%
    % \@startsection {section}{1}{\z@}%
	% {-3.5ex \@plus -1ex \@minus -.2ex}%
	% {2.3ex \@plus.2ex}%
	% {\reset@font\Large\bfseries}
%  }
\raggedbottom

\setcounter{secnumdepth}{3}
\renewcommand{\thesection}{\arabic{section}}
\RequirePackage{titletoc}
\titlecontents*{chapter}% <section-type>
  [0pt]% <left>
  {}% <above-code>
  {\bfseries \thecontentslabel\quad}% <numbered-entry-format>
  {}% <numberless-entry-format>
  {\bfseries\hfill\contentspage}% <filler-page-format>


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% BOITES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\RequirePackage{tikz,environ}
\tikzstyle{mybox} = [draw=black, very thick,
    rectangle, inner sep=10pt, inner ysep=20pt]
\tikzstyle{fancytitle} = [draw=black, fill=white, text=black]

\NewEnviron{defin}{\par
\begin{center}
\begin{tikzpicture}
\node [mybox] (box){%
    \begin{minipage}{0.8\textwidth}
    	\BODY
	\end{minipage} };
\node[fancytitle, right=10pt] at (box.north west) {\textbf{Définition}};
\end{tikzpicture}\end{center}\par
}

% \NewEnviron{thm}{\par
% \begin{center}
% \begin{tikzpicture}
% \node [mybox] (box){%
%     \begin{minipage}{0.8\textwidth}
%     	\BODY
% 	\end{minipage} };
% \node[fancytitle, right=10pt] at (box.north west) {\textbf{Théorème}};
% \end{tikzpicture}\end{center}\par
%}

\RequirePackage{thmbox}
\RequirePackage{xparse}
\NewDocumentEnvironment{prop}{o}{%
\begin{center}\begin{minipage}{0.8\textwidth}
  \thmbox[M]{\textbf{Proposition \IfNoValueTF{#1}{}{\em (#1)}}}%
  %\hspace*{-1.5em}%
  }
  {%
  \endthmbox\vspace*{.75ex}\end{minipage}\end{center}%
  }

\NewDocumentEnvironment{thm}{o}{%
\begin{center}\begin{minipage}{0.8\textwidth}
  \thmbox[M]{\textbf{Théorème \IfNoValueTF{#1}{}{\em (#1)}}}%
  %\hspace*{-1.5em}%
  }
  {%
  \endthmbox\vspace*{.75ex}\end{minipage}\end{center}%
  }


\NewDocumentEnvironment{corol}{o}{%
	\begin{center}\begin{minipage}{0.8\textwidth}
			\thmbox[M]{\textbf{Corollaire \IfNoValueTF{#1}{}{\em (#1)}}}%
			%\hspace*{-1.5em}%
		}
		{%
			\endthmbox\vspace*{.75ex}\end{minipage}\end{center}%
}

\NewDocumentEnvironment{lemme}{o}{%
	\begin{center}\begin{minipage}{0.8\textwidth}
			\thmbox[M]{\textbf{Lemme \IfNoValueTF{#1}{}{\em (#1)}}}%
			%\hspace*{-1.5em}%
		}
		{%
			\endthmbox\vspace*{.75ex}\end{minipage}\end{center}%
}

\newenvironment{rem}{\par\medbreak
   \noindent\textbf{Remarque: }\nopagebreak}{\medbreak\par}
\newenvironment{exemple}[1][\unskip]{\par\medbreak\noindent\textbf{Exemple: }\textit{#1}  \nopagebreak}{\bigbreak\par}
\newenvironment{preuve}{\par\textit{Démonstration: }\nopagebreak}{\par}
