\NeedsTeXFormat{LaTeX2e} 
\ProvidesClass{homework}[2019/01/12]

\newif\ifusingminion \usingminionfalse
\DeclareOption{minion}{\usingminiontrue}

% Option noname controls whether the student name should appear in
% the header or not.  By default it does.
\newif\ifhandout \handoutfalse
\DeclareOption{handout}{\handouttrue}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[12pt]{article} 

\RequirePackage{color}
\newcommand{\exercise}[1]{\textbf{\color{blue}Exercise #1}}

\RequirePackage{amssymb,amsmath,amsthm}
\RequirePackage[top=1in, bottom=1in, left=1.25in, right=1.25in]{geometry}

\IfFileExists{MinionPro.sty}{}{\usingminionfalse}
\ifusingminion
\RequirePackage[lf]{MinionPro}
%% Error message wierdness from the MinionPro package.  The following line fixes it. I don't know why.
\let\mathdollar\undefined 
\else
\usepackage{times,txfonts}
\fi

\parindent 0pt
\parskip 6pt plus 1pt

\newtheoremstyle{ex215}% name of the style to be used
  {18pt}% measure of space to leave above the theorem. E.g.: 3pt
  {12pt}% measure of space to leave below the theorem. E.g.: 3pt
  {}% name of font to use in the body of the theorem
  {}% measure of space to indent
  {\bfseries}% name of head font
  {:}% punctuation between head and body
  {2ex}% space after theorem head; " " = normal interword space
  {}% Manually specify head
\theoremstyle{ex215} 

\newtheorem*{lemma}{Lemma \@currentlabel}


\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyfoot[C]{\ifnum \value{page} > 1\relax\thepage\fi}
\fancyhead[L]{\ifx\@doclabel\@empty\else\@doclabel\fi}
\fancyhead[C]{\ifx\@docauthor\@empty\else\@docdate\fi}
\fancyhead[R]{\ifx\@docauthor\@empty\@docdate\else\@docauthor\fi}
\headheight 15pt


\def\doclabel#1{\gdef\@doclabel{#1}}
\doclabel{Use {\tt\textbackslash doclabel\{MY LABEL\}}.}
\def\docdate#1{\gdef\@docdate{#1}}
\docdate{Use {\tt\textbackslash docdate\{MY DATE\}}.}
\def\docauthor#1{\gdef\@docauthor{#1}}
%\docauthor{Use {\tt\textbackslash docauthor\{MY NAME\}}.}
\let\@docauthor\@empty

\newcounter{probcount}
\newcounter{subprobcount}
\newlength\probsep
\newlength\pshrinking
\newif\iffirstprob

% The following commands allow for a handy override of labels in an enumeration,
% without having the user keep track of what level the enumeration is happening at.
% To use them, just put \listlabel{....} as the first command after a \begin{enumerate}.
% The '....' is used to define the label.  You can access the name of the current label
% counter with \thelistlabel.  Hence \listlabel{\textbf{\Alph{\thelistlabel}:}} would
% generate lists with bold labels A:, B:, C:, etc.
\newcommand{\listlabelt}[1]{\def\thelistlabel{\@enumctr}%
            \expandafter\def\csname label\@enumctr\endcsname{#1}}


\newenvironment{subproblems}%
  {\begin{enumerate}\listlabelt{\alph{\thelistlabel})}%
  %% Make the enumerate environment think we are making a list in a list:
  \global \@newlistfalse}%
  {\end{enumerate}}%

\newenvironment{problems}%
  {\ifhmode\unskip\par\fi\setcounter{probcount}{0}\probsep\parskip
  \sbox\@tempboxa{\textbf{9.}}\pshrinking\wd\@tempboxa\advance\pshrinking\labelsep
  \advance\linewidth -\pshrinking
  \advance\@totalleftmargin\pshrinking
  \advance\leftskip\pshrinking}%
  {\ifhmode\unskip \par\fi\advance\leftskip-\pshrinking}%

\newcommand{\problem}{%
  \setcounter{subprobcount}{0}%
  \stepcounter{probcount}%
  \def\@currentlabel{\arabic{probcount}}%
  \ifhmode
    \unskip \par
  \fi
%  \addpenalty{-4000}%
  \iffirstprob\else\addvspace\probsep\fi
  \firstprobfalse
  \hskip -\labelwidth\hskip -\labelsep 
  \hbox to\labelwidth{\hss\textbf{\arabic{probcount}.}}\hskip\labelsep
}%

%% The localhead command puts a label on top of a paragraph -- handy for labels
%% like "Solution:"
\newskip\restoreparskip
\newcommand{\localhead}[1]{\par\smallskip\textbf{#1}\nobreak\\}%
%% The following arcane code was added to make the localhead enviroment get along
%% with the ams theorem enviroment (which is based on the latex list enviroment).
%% previously, the command was {\par\smallskip\textbf{#1}\\}, but the list
%% enviroment would also add a par at the end of this paragraph, which would result
%% in an extra blank line.  Our solution now is to put in our own par, but with
%% none of the parskip glue that adds extra space between paragraphs.
%%  \restoreparskip\parskip\parskip 0pt\par\nobreak\noindent\parskip\restoreparskip}%
\newcommand\solution{\localhead{Solution:}}
\newcommand\subsol{\stepcounter{subprobcount}\localhead{Solution, part \alph{subprobcount}:}}
\newcommand\subsoleg[1]{\stepcounter{subprobcount}\par\textbf{Solution, part \alph{subprobcount}:} #1\\}
\def\solver#1{(Solution by #1)\\\vskip-12pt}


%% The default 'article' class has captions that label figures Figure 1, etc.  This is too 
%% formal for homework sets, so we change \caption so that it just puts the caption text.
%% Here I have just modified the \@makecaption command from the article class.
%% Maybe I should change this in the future to let authors decide whether or not to label a figure.

\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{#2}%
  \ifdim \wd\@tempboxa >\hsize
    #2\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}

%% The default implementation of the proof environment starts a new paragraph at the start of the proof,
%% with the full parskip spacing. This only looks good following a theorem statement 
%% if \parskip is set to zero.  We've got a medium sized parskip, so we overide this 
%% questionable decision.
\renewenvironment{proof}[1][\proofname]{\par
  \pushQED{\qed}%
  \normalfont \topsep6\p@\@plus6\p@\relax
  \trivlist
  \@topsep \topsep
  \item[\hskip\labelsep
        \itshape
    #1\@addpunct{.}]\ignorespaces
}{%
  \popQED\endtrivlist\@endpefalse
}


%% The begin/end mechanism is a little cumbersome when doing theorems and proofs:
%% \begin{theorem} ... \end{theorem} \begin{proof} ... \end{proof}
%%
%% Instead, we do:
%% \theorem .... \Proof ... \EOP
%% or
%%
%% \theorem .... \NoProof
%%
%% To use this mechanism, use:
%%
%% \eztheorem{startcommand}[counter]{label}
%%
%% E.g. \eztheorem{theorem}{Theorem} makes a \theorem command
%%      \eztheorem{lemma}[theorem]{Lemma} makes a \lemma command that uses the same
%%  numbering counter as the theorem command. i.e,
%%  Theorem 1, Lemma 2, Theorem 3   vs.   Theorem 1, Lemma 2, Theorem 2
%
\def\eztheorem#1{\ezthmnol@{#1}}
\def\eztheorem#1{\@ifnextchar[{\ezthm@{#1}}{\ezthmnol@{#1}}}
\def\ezthm@#1[#2]#3{\newtheorem{ezthm#1}[ezthm#2]{#3}\expandafter\gdef\csname#1\endcsname{\ezstartthm{ezthm#1}}}

\def\ezthmnol@#1#2{\newtheorem{ezthm#1}{#2}\expandafter\gdef\csname #1\endcsname{\ezstartthm{ezthm#1}}}
\newcommand{\NoProof}{\end{\ezthmenv}\egroup}
\newcommand{\Proof}{\end{\ezthmenv}\egroup\begin{proof}}
\newcommand{\EOP}{\end{proof}}
\def\ezstartthm#1{\bgroup\def\ezthmenv{#1}\begin{\ezthmenv}}
%%
%% Declare the theorem types for problem sets.  
%%
\eztheorem{theorem}{Theorem}
\eztheorem{corollary}[theorem]{Corollary}
\eztheorem{proposition}[theorem]{Proposition}
\eztheorem{lemma}[theorem]{Lemma}
