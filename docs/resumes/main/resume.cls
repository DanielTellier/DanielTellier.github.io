\ProvidesClass{resume}[Resume Class]

\LoadClass[10pt,letterpaper]{article} % Font size and paper type

\usepackage[parfill]{parskip} % Remove paragraph indentation
\usepackage{array} % Required for boldface (\bf and \bfseries) tabular columns
\usepackage{ifthen} % Required for ifthenelse statements

\pagestyle{empty} % Suppress page numbers

\def \name#1{\def\@name{#1}} % Defines the \name command to set name
\def \@name {} % Sets \@name to empty by default

\def \career#1{\def\@career{#1}}
\def \@career {}

% \printname is used to print the name as a page header
\def \printname {
  \begingroup
    \begin{center}
        {\MakeUppercase{\namesize\bf \@name}}
    \end{center}
  \endgroup
}

\def \printcareer {
    \begingroup
        \begin{center}
            {\careersize\bf \@career}
        \end{center}
    \endgroup
}

%% PRINT THE HEADING LINES
\let\ori@document=\document
\renewcommand{\document}{
  \ori@document  % Begin document
  \printname % Print the name specified with \name
  \printcareer
}

%% SECTION FORMATTING
% Defines the rSection environment for the large sections within the CV
\newenvironment{rSection}[1]{ % 1 input argument - section name
  \sectionskip
  \MakeUppercase{\bf #1} % Section title
  \sectionlineskip
  \hrule % Horizontal line
  \begin{list}{}{ % List for each individual item in the section
    \setlength{\leftmargin}{0em} % Margin within the section
  }
  \item[]
}{
  \end{list}
}

%% WORK EXPERIENCE FORMATTING
\newenvironment{rSubsection}[2]{ % 2 input arguments - job info and duration
 {\bf #1} \hfill {#2} % Bold job info and duration on right
  \smallskip
  \begin{list}{$\cdot$}{\leftmargin=1em} % \cdot used for bullets, no indentation
  \itemsep -0.5em \vspace{-0.5em} % Compress items in list together for aesthetics
  }{
  \end{list}
  \vspace{0.25em} % Some space after the list of bullet points
}

%% EXTRA WHITESPACE OPTIONS
\def\namesize{\Large} % Size of the name at the top of the document
\def\careersize{\large}
\def\sectionlineskip{\smallskip} % The space above the horizontal line for each section 
\def\nameskip{\smallskip} % The space after your name at the top
\def\sectionskip{\smallskip} % The space after the heading section
