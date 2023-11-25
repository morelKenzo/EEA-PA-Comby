\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{../../td}[2019/01/09 LaTeX class for Lessons]
\makeatletter
% Base Class

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}


\ProcessOptions\relax
% Main packages

\LoadClass[12pt,a4paper,french,notitlepage]{book}


\RequirePackage[french]{babel} % pour ecrire en francais
\RequirePackage[left=2.00cm, right=2.00cm, top=3.00cm, bottom=3.00cm]{geometry} % la mise en page

% Packages
\RequirePackage[utf8]{inputenc} % encodage
\RequirePackage[T1]{fontenc}
\RequirePackage{fancyhdr} % la mise en page
\RequirePackage[dvipsnames,x11names]{xcolor} % Un peu de couleur !
\RequirePackage{float}
\RequirePackage{subfiles}
\RequirePackage{hyperref}
\RequirePackage{multicol}
\RequirePackage{graphicx}
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
\def\teacher#1{\gdef\@teacher{#1}}
\def\module#1{\gdef\@module{#1}}
\RequirePackage{fancyhdr}
\pagestyle{fancy}
   \fancyhf {}
   \renewcommand{\headrulewidth}{1pt}   %Epaisseur de la ligne.
   \renewcommand{\footrulewidth}{1pt}   %Epaisseur de la ligne.
   \lhead{UE\@module}
   \rhead{\rightmark}
   \cfoot{\thepage{}}
\RequirePackage{mathtools}
\RequirePackage{amsfonts}
\RequirePackage{mathrsfs}

\RequirePackage{tikz}
\usetikzlibrary{fit}
\usetikzlibrary{positioning}
\RequirePackage{schemabloc} 
\RequirePackage[european,cuteinductors,siunitx,straightvoltages]{circuitikz}
\tikzset{every picture/.style={execute at begin picture={\shorthandoff{:;!?};}}}
\usetikzlibrary{positioning, fit, calc}
\RequirePackage{pgfplots}
\RequirePackage{amssymb}
\RequirePackage[section]{placeins} % Oblige a placer toutes les figures avant de passer a la section suivante

\RequirePackage{titlesec} % nouvelle page a chaque section (ie TD)
\newcommand{\sectionbreak}{\clearpage}
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
          {\Huge \textbf{\textsc{Module \@module}}}\\
          %\baselineskip=0.5\baselineskip
        }\vfill
        \@ifundefined{@title}
        {}
 		{{\LARGE \textbf{\@title}}}
 		\vfill
        \@ifundefined{@date}{}{%
 		{\LARGE Version du \@date}
        \vfill}
      \@ifundefined{@author}
        {}{%
          {\Large
            \begin{minipage}[t]{0.5\linewidth}
              \raggedright
              \underline{Un cours de:} \\
              \textsc{\@teacher}
            \end{minipage}\hfill
            \begin{minipage}[t]{0.5\linewidth}
              \raggedleft
              \underline{Rédigé et amélioré par:} \\
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
