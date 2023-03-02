% 初始化
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{simplebeamer}[2023/1/28 v0.01 SimpleBeamer class]

% 设置参数
\RequirePackage{kvoptions}
\RequirePackage{etoolbox}
\RequirePackage{calc}

\SetupKeyvalOptions{family=SIMPLE, prefix=SIMPLE@, setkeys=\kvsetkeys}
\newcommand{\skv}[1]{\kvsetkeys{SIMPLE}{#1}}

% 获取语言参数，默认英文
\DeclareStringOption[en]{lang}
\DeclareVoidOption{cn}{\skv{lang=cn}}
\DeclareVoidOption{en}{\skv{lang=en}}

% 获取logo参数，默认off
\DeclareStringOption[off]{logo}
\DeclareVoidOption{on}{\skv{lang=on}}
\DeclareVoidOption{off}{\skv{lang=off}}

% 获取中文字体参数，默认 founder
\DeclareStringOption[founder]{chinesefont}
\DeclareVoidOption{ctexfont}{\skv{chinesefont=ctexfont}}
\DeclareVoidOption{founder}{\skv{chinesefont=founder}}
\DeclareVoidOption{nofont}{\skv{chinesefont=nofont}}

% 获取主题参数，默认 metropolis
\DeclareStringOption[default]{theme}
\DeclareVoidOption{default}{\skv{theme=default}}
\DeclareVoidOption{retro}{\skv{theme=retro}}
\DeclareVoidOption{dark}{\skv{theme=dark}}
\DeclareVoidOption{jet}{\skv{theme=jet}}

% 设置引用格式
\DeclareStringOption[numeric-comp]{citestyle}
\DeclareStringOption[numeric]{bibstyle}
\DeclareStringOption[biber]{bibend}
\DeclareVoidOption{biber}{\ekv{bibend=biber}}
\DeclareVoidOption{bibtex}{\ekv{bibend=bibtex}}

% 关闭字体警告
\PassOptionsToPackage{quiet}{fontspec}
\PassOptionsToPackage{quiet}{xeCJK}

% 加载 beamer
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{beamer}}
\ProcessKeyvalOptions*\relax
\LoadClass[notheorems]{beamer}

% 数学相关包
\RequirePackage{amsthm}
\RequirePackage{amsmath}
\RequirePackage{amssymb}

% 颜色
\RequirePackage{color}
\RequirePackage{xcolor}
\RequirePackage{framed}

% 图片
\RequirePackage{graphicx}
\RequirePackage{subcaption}
\RequirePackage{float}

\RequirePackage{algorithm}
\RequirePackage{algorithmic}
\RequirePackage{listings}
\lstdefinestyle{estyle}{
    basicstyle=%
    \ttfamily
    \lst@ifdisplaystyle\footnotesize\fi
}
\lstset{basicstyle=\scriptsize\ttfamily,style=estyle}
\lstset{language=[LaTeX]TeX,
    texcsstyle=*\color{winered},
    numbers=none,
    breaklines=true,
    keywordstyle=\color{winered},
    frame=tlbr,framesep=4pt,framerule=0pt,
    commentstyle=\color{commentcolor},
    emph={elegantpaper,fontenc,fontspec,xeCJK,FiraMono,xunicode,newtxmath,figure,fig,image,img,table,itemize,enumerate,newtxtext,newtxtt,ctex,microtype,description,times,newtx,booktabs,tabular,PDFLaTeX,XeLaTeX,type1cm,BibTeX,cite,gbt7714,lang},
    emphstyle={\color{frenchplum}},
    morekeywords={DeclareSymbolFont,SetSymbolFont,toprule,midrule,bottomrule,institute,version,includegraphics,setmainfont,setsansfont,setmonofont ,setCJKmainfont,setCJKsansfont,setCJKmonofont,RequirePackage,figref,tabref,email,maketitle,keywords,zhdate,zhtoday},
    tabsize=2,
    backgroundcolor=\color{lightgrey}
}

% 其他
\RequirePackage{anyfontsize}
\RequirePackage{iftex}
\RequirePackage{silence}

% 定义引用颜色
\definecolor{HEYELV}{HTML}{1a6840}
\definecolor{YEHUI}{HTML}{847c74}
\definecolor{DANQINZI}{HTML}{e0c8d1}
\definecolor{YOULAN}{HTML}{1781b5}
\definecolor{winered}{rgb}{0.5,0,0}
\definecolor{lightgrey}{rgb}{0.95,0.95,0.95}
\definecolor{commentcolor}{RGB}{0,100,0}
\definecolor{frenchplum}{RGB}{190,20,83}
\definecolor{shadecolor}{rgb}{0.95,0.95,0.95}

% 设置引用格式
\RequirePackage[
    backend=\SIMPLE@bibend,
    citestyle=\SIMPLE@citestyle,
    bibstyle=\SIMPLE@bibstyle,
]{biblatex}
\defbibheading{simplepaper}[\ebibname]{
    \section*{#1}
    \addcontentsline{toc}{section}{#1}
}
\def\bibfont{\footnotesize}

% 设置引用文件
\addbibresource{ref.bib}

% 设置链接格式
\RequirePackage{hyperref}
\hypersetup{
    pdfborder={0 0 0},
    colorlinks=true,
    linkcolor={HEYELV},
    urlcolor={YEHUI},
    filecolor={DANQINZI},
    citecolor={YOULAN},
    linktoc=all,
}

% 使用cleveref包用于引用公式图片表格等
\WarningsOff
\RequirePackage[capitalise]{cleveref}
\WarningsOn
% 公式引用只显示括号
\crefname{equation}{}{}
% 设置bm为boldsymbol
\newcommand{\bm}[1]{\boldsymbol{#1}}

% 设置字体
\ifcsname kaishu\endcsname
    \newcommand{\citshape}{\kaishu}
\else
    \newcommand{\citshape}{\itshape}
\fi
\ifcsname kaishu\endcsname
    \newcommand{\cnormal}{\kaishu}
\else
    \newcommand{\cnormal}{\normalfont}
\fi

\ifcsname fangsong\endcsname
    \newcommand{\cfs}{\fangsong}
\else
    \newcommand{\cfs}{\normalfont}
\fi

% 判断是否压缩图片
\ifdefstring{\SIMPLE@style}{nocomp}{
    \special{dvipdfmx:config z 0}
}
\vfuzz=500pt
\hfuzz=500pt

\usefonttheme{professionalfonts}
\usetheme{metropolis}

% logo 设置
\ifdefstring{\SIMPLE@logo}{on}{
    \RequirePackage{tikz}
    \titlegraphic{
        \vspace*{.55\paperheight-.08\paperwidth}
        \hspace*{.6\paperwidth-.08\paperwidth}
        \begin{tikzpicture}
            \clip (0,0) circle (.08\paperwidth);
            \node at (0,0) {\includegraphics[width=.16\paperwidth]{./img/logo}};
        \end{tikzpicture}
    }
    \logo{
        \begin{tikzpicture}[fill opacity=0.4]
            \clip (0,0) circle (.05\paperwidth);
            \node at (0,0) {\includegraphics[width=.1\paperwidth]{./img/logo}};
        \end{tikzpicture}
        \hspace*{.85\paperwidth}
        \vspace*{-.05\paperwidth}
    }
}

% 设置中文字体
\ifdefstring{\SIMPLE@lang}{cn}{
    \renewcommand{\today}{\number\year 年 \number\month 月 \number\day 日}

    \ifdefstring{\SIMPLE@chinesefont}{ctexfont}{
        \RequirePackage[UTF8,scheme=plain]{ctex}
    }{\relax}

    \ifdefstring{\SIMPLE@chinesefont}{founder}{
        \RequirePackage[UTF8,scheme=plain,fontset=none]{ctex}
        \setmainfont{FZHei-B01}
        \setCJKmainfont[BoldFont={FZHei-B01},ItalicFont={FZKai-Z03}]{FZShuSong-Z01}
        \setCJKsansfont[BoldFont={FZHei-B01}]{FZKai-Z03}
        \setCJKmonofont[BoldFont={FZHei-B01}]{FZFangSong-Z02}
        \setCJKfamilyfont{zhsong}{FZShuSong-Z01}
        \setCJKfamilyfont{zhhei}{FZHei-B01}
        \setCJKfamilyfont{zhkai}[BoldFont={FZHei-B01}]{FZKai-Z03}
        \setCJKfamilyfont{zhfs}[BoldFont={FZHei-B01}]{FZFangSong-Z02}
        \newcommand*{\songti}{\CJKfamily{zhsong}}
        \newcommand*{\heiti}{\CJKfamily{zhhei}}
        \newcommand*{\kaishu}{\CJKfamily{zhkai}}
        \newcommand*{\fangsong}{\CJKfamily{zhfs}}
    }{\relax}

    \ifdefstring{\SIMPLE@chinesefont}{nofont}{
        \RequirePackage[UTF8,scheme=plain,fontset=none]{ctex}
    }{\relax}

    \AfterEndPreamble{\setlength\parindent{2\ccwd}}
}{\relax}

% 设置中文环境名称
\ifdefstring{\SIMPLE@lang}{cn}{
    \theoremstyle{plain}% default
    \newtheorem{theorem}{定理}[section] %
    \newtheorem{lemma}[theorem]{引理} %
    \newtheorem{proposition}[theorem]{命题} %
    \newtheorem{property}[theorem]{性质}
    \newtheorem*{corollary}{推论} %
    \theoremstyle{definition} %
    \newtheorem{definition}{定义}[section] %
    \newtheorem{conjecture}{猜想}[section] %
    \newtheorem{example}{例}[section] %
    \theoremstyle{remark} %
    \newtheorem*{remark}{\normalfont\bfseries 评论} %
    \let\note\relax
    \newtheorem*{note}{\normalfont\bfseries 注} %
    \newtheorem{case}{\normalfont\bfseries 案例} %
    \renewcommand*{\proofname}{\normalfont\bfseries 证明} %
    \renewcommand\contentsname{目录}
    \renewcommand\refname{参考文献} %
    \renewcommand\figurename{图} %
    \renewcommand\tablename{表}%
    \newcommand\versiontext{版本：}%
    \newcommand\updatetext{日期：}%
    \newcommand{\ebibname}{参考文献}
    \renewcommand{\ALG@name}{算法}
    \setlength\parindent{2\ccwd}
    \renewcommand{\algorithmicrequire}{\textbf{输入：}}
    \renewcommand{\algorithmicensure}{\textbf{输出：}}

    \newcommand{\crefrangeconjunction}{~到~}
    \newcommand{\crefpairconjunction}{~和~}
    \newcommand{\crefmiddleconjunction}{、}
    \newcommand{\creflastconjunction}{~和~}
    \newcommand{\crefpairgroupconjunction}{~和~}
    \newcommand{\crefmiddlegroupconjunction}{、}
    \newcommand{\creflastgroupconjunction}{~和~}

    \crefname{equation}{式}{式}
    \crefname{figure}{图}{图}
    \crefname{table}{表}{表}
    \crefname{theorem}{定理}{定理}
    \crefname{lemma}{引理}{引理}
    \crefname{proposition}{命题}{命题}
    \crefname{corollary}{推论}{推论}
    \crefname{property}{性质}{性质}
    \crefname{definition}{定义}{定义}
    \crefname{conjecture}{猜想}{猜想}
    \crefname{example}{例}{例}
    \crefname{appendix}{附录}{附录}
    \crefname{algorithm}{算法}{算法}

    \crefname{chapter}{章}{章}
    \crefname{section}{节}{节}
    \crefname{subsection}{小节}{小节}

}{\relax}

% 设置英文环境名称
\ifdefstring{\SIMPLE@lang}{en}{
    \theoremstyle{plain}% default
    \newtheorem{theorem}{Theorem}[section] %
    \newtheorem{lemma}[theorem]{Lemma} %
    \newtheorem{proposition}[theorem]{Proposition} %
    \newtheorem*{corollary}{Corollary} %
    \theoremstyle{definition} %
    \newtheorem{definition}{Definition}[section] %
    \newtheorem{conjecture}{Conjecture}[section] %
    \newtheorem{example}{Example}[section] %
    \theoremstyle{remark} %
    \newtheorem*{remark}{Remark} %
    \let\note\relax
    \newtheorem*{note}{Note} %
    \newtheorem{case}{Case} %
    \renewcommand*{\proofname}{\normalfont\bfseries Proof}%
    \newcommand\versiontext{\itshape Version: }%
    \newcommand\updatetext{\itshape Date: }%
    \setlength\parindent{2em}
    \newcommand\figref[1]{{\bfseries Figure~\ref{#1}}}
    \newcommand\tabref[1]{{\bfseries Table~\ref{#1}}}
    \newcommand{\ebibname}{Reference}
    \renewcommand{\algorithmicrequire}{\textbf{Input:}}
    \renewcommand{\algorithmicensure}{\textbf{Output:}}
}{\relax}


% 自定义色彩
% default
\ifdefstring{\SIMPLE@theme}{default}{
    \definecolor{pri}{HTML}{27373A}
    \definecolor{sec}{HTML}{DD8638}
    \definecolor{ter}{HTML}{27373A}
    \definecolor{ale}{HTML}{CD3357}
    \definecolor{txt}{HTML}{000000}
    \definecolor{bkg}{HTML}{FFFFFF}
}{\relax}

% retro
\ifdefstring{\SIMPLE@theme}{retro}{
    \definecolor{pri}{HTML}{556D7F}
    \definecolor{sec}{HTML}{ED5126}
    \definecolor{ter}{HTML}{2E3840}
    \definecolor{ale}{HTML}{FF0303}
    \definecolor{txt}{HTML}{000000}
    \definecolor{bkg}{HTML}{FFFFFF}
}{\relax}

% dark
\ifdefstring{\SIMPLE@theme}{dark}{
    \definecolor{pri}{HTML}{B9F3FC}
    \definecolor{sec}{HTML}{AEE2FF}
    \definecolor{ter}{HTML}{93C6E7}
    \definecolor{ale}{HTML}{FEDEFF}
    \definecolor{txt}{HTML}{FFFFFF}
    \definecolor{bkg}{HTML}{000000}
}{\relax}

% jet
\ifdefstring{\SIMPLE@theme}{jet}{
    \definecolor{pri}{HTML}{F5E9CF}
    \definecolor{sec}{HTML}{E96479}
    \definecolor{ter}{HTML}{4D455D}
    \definecolor{ale}{HTML}{7DB9B6}
    \definecolor{txt}{HTML}{000000}
    \definecolor{bkg}{HTML}{FFFFFF}
}{\relax}

% set beamer color
\setbeamercolor{title}{fg=pri}
\setbeamercolor{title separator}{fg=sec}
\setbeamercolor{author}{fg=ter}
\setbeamercolor{institute}{fg=ter}
\setbeamercolor{date}{fg=ter}

\setbeamercolor*{palette primary}{fg=white,bg=pri}
\setbeamercolor*{palette secondary}{fg=white,bg=sec}
\setbeamercolor*{palette tertiary}{fg=pri,bg=ter}

\setbeamercolor{alerted text}{fg=ale}
\setbeamercolor*{block title}{bg=pri!30!white}

\setbeamercolor{normal text}{fg=txt}
\setbeamercolor{background canvas}{bg=bkg}
