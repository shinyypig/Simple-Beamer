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
\DeclareVoidOption{en}{\skv{lang=en}}
\DeclareVoidOption{cn}{\skv{lang=cn}}

% 获取logo参数，默认off
\DeclareStringOption[off]{logo}
\DeclareVoidOption{off}{\skv{lang=off}}
\DeclareVoidOption{on}{\skv{lang=on}}

% 获取中文字体参数，默认 plain
\DeclareStringOption[plain]{chinesefont}
\DeclareVoidOption{plain}{\skv{chinesefont=plain}}
\DeclareVoidOption{founder}{\skv{chinesefont=founder}}
\DeclareVoidOption{nofont}{\skv{chinesefont=nofont}}

% 获取主题参数，默认 default(metropolis)
\DeclareStringOption[default]{theme}
\DeclareVoidOption{default}{\skv{theme=default}}
\DeclareVoidOption{retro}{\skv{theme=retro}}
\DeclareVoidOption{dark}{\skv{theme=dark}}
\DeclareVoidOption{jet}{\skv{theme=jet}}

% 设置引用格式
\DeclareStringOption[numeric-comp]{citestyle}
\DeclareStringOption[numeric]{bibstyle}
\DeclareStringOption[biber]{bibend}

% 设置编译模式
\DeclareStringOption[final]{mode}
\DeclareVoidOption{final}{\skv{mode=final}}
\DeclareVoidOption{preprint}{\skv{mode=preprint}}
\DeclareVoidOption{nocomp}{\skv{mode=nocomp}}

% 设置标题页面层级
\DeclareStringOption[section]{page}
\DeclareVoidOption{section}{\skv{page=section}}
\DeclareVoidOption{subsection}{\skv{page=subsection}}

% 关闭字体警告
\PassOptionsToPackage{quiet}{fontspec}
\PassOptionsToPackage{quiet}{xeCJK}

% 加载 beamer
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{beamer}}
\ProcessKeyvalOptions*\relax
\LoadClass[notheorems,hyperref]{beamer}

% 判断是否显示行号
\ifdefstring{\SIMPLE@mode}{preprint}{
    \RequirePackage{lineno}
    \linenumbers
}

% 判断是否压缩图片
\ifdefstring{\SIMPLE@mode}{nocomp}{
    \RequirePackage{lineno}
    \linenumbers
    \special{dvipdfmx:config z 0}
}

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
\RequirePackage{animate}

% 标题前后间距
\captionsetup{font=footnotesize,skip=5pt}
\captionsetup[subfigure]{skip=5pt,belowskip=1pt}
\captionsetup[table]{skip=5pt,belowskip=1pt}

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
\RequirePackage{multicol}
\RequirePackage{multirow}

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
    sorting=none
]{biblatex}
\defbibheading{simplebeamer}[\ebibname]{
    \section*{#1}
    \addcontentsline{toc}{section}{#1}
}
\def\bibfont{\footnotesize}

% 设置引用文件
\addbibresource{ref.bib}

% 使用cleveref包用于引用公式图片表格等
\WarningsOff
\RequirePackage[capitalise]{cleveref}
\WarningsOn

% cleveref 使用 hyperlink
\let\chyperref\cref
\renewcommand{\cref}[1]{\hyperlink{#1}{\chyperref{#1}}}

% 设置bm为boldsymbol
\newcommand{\bm}[1]{\boldsymbol{#1}}

% 消除警告
\vfuzz=500pt
\hfuzz=500pt

% 设置英文字体
\usefonttheme{professionalfonts}

% 使用 metropolis 主题
\ifdefstring{\SIMPLE@page}{section}{
    \usetheme{metropolis}
}{\relax}
\ifdefstring{\SIMPLE@page}{subsection}{
    \usetheme[sectionpage=none,subsectionpage=progressbar]{metropolis}
}{\relax}

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
        \begin{tikzpicture}[fill opacity=0.15]
            \clip (0,0) circle (.05\paperwidth);
            \node at (0,0) {\includegraphics[width=.1\paperwidth]{./img/logo}};
        \end{tikzpicture}
        \hspace*{.88\paperwidth}
        \vspace*{-.07\paperwidth}
    }
}

% 设置中文字体
\ifdefstring{\SIMPLE@lang}{cn}{
    \renewcommand{\today}{\number\year 年 \number\month 月 \number\day 日}

    \ifdefstring{\SIMPLE@chinesefont}{plain}{
        \RequirePackage[UTF8,scheme=plain]{ctex}
    }{\relax}

    \ifdefstring{\SIMPLE@chinesefont}{founder}{
        \RequirePackage[UTF8,scheme=plain,fontset=none]{ctex}
        \setCJKsansfont{FZShuSong-Z01}[
            UprightFont={FZFangSong-Z02},
            BoldFont={FZHei-B01},
            ItalicFont={FZKai-Z03},
            BoldItalicFont={FZHei-B01},
        ]
    }{\relax}

    \ifdefstring{\SIMPLE@chinesefont}{nofont}{
        \RequirePackage[UTF8,scheme=plain,fontset=none]{ctex}
    }{\relax}
}{\relax}

% 设置中文环境名称
\ifdefstring{\SIMPLE@lang}{cn}{
    \theoremstyle{plain}% default
    \newtheorem{theorem}{定理} %
    \newtheorem{lemma}{引理} %
    \newtheorem{proposition}{命题} %
    \newtheorem{property}{性质} %
    \newtheorem{corollary}{推论} %
    \newtheorem{definition}{定义}%
    \newtheorem{conjecture}{猜想} %
    \newtheorem{example}{例} %
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
    \newtheorem{lemma}{Lemma}[section] %
    \newtheorem{proposition}{Proposition}[section] %
    \newtheorem{property}{Property}[section] %
    \newtheorem{corollary}{Corollary}[section] %
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
    \newcommand\figref[1]{{\bfseries Figure~\ref{#1}}}
    \newcommand\tabref[1]{{\bfseries Table~\ref{#1}}}
    \newcommand{\ebibname}{Reference}
    \renewcommand{\algorithmicrequire}{\textbf{Input:}}
    \renewcommand{\algorithmicensure}{\textbf{Output:}}
    \crefname{equation}{}{}
}{\relax}

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

% 自定义色彩
% default
\ifdefstring{\SIMPLE@theme}{default}{
    \definecolor{pri}{HTML}{27373A}
    \definecolor{sec}{HTML}{DD8638}
    \definecolor{ter}{HTML}{27373A}
    \definecolor{ale}{HTML}{DD8638}
    \definecolor{txt}{HTML}{000000}
    \definecolor{bkg}{HTML}{FFFFFF}
    \definecolor{blk}{HTML}{CCD3D8}
}{\relax}

% retro
\ifdefstring{\SIMPLE@theme}{retro}{
    \definecolor{pri}{HTML}{556D7F}
    \definecolor{sec}{HTML}{DD8638}
    \definecolor{ter}{HTML}{2E3840}
    \definecolor{ale}{HTML}{DD8638}
    \definecolor{txt}{HTML}{000000}
    \definecolor{bkg}{HTML}{FFFFFF}
    \definecolor{blk}{HTML}{CCD3D8}
}{\relax}

% dark
\ifdefstring{\SIMPLE@theme}{dark}{
    \definecolor{pri}{HTML}{B9F3FC}
    \definecolor{sec}{HTML}{AEE2FF}
    \definecolor{ter}{HTML}{93C6E7}
    \definecolor{ale}{HTML}{FEDEFF}
    \definecolor{txt}{HTML}{FFFFFF}
    \definecolor{bkg}{HTML}{000000}
    \definecolor{blk}{HTML}{CCD3D8}
}{\relax}

% jet
\ifdefstring{\SIMPLE@theme}{jet}{
    \definecolor{pri}{HTML}{F5E9CF}
    \definecolor{sec}{HTML}{E96479}
    \definecolor{ter}{HTML}{4D455D}
    \definecolor{ale}{HTML}{7DB9B6}
    \definecolor{txt}{HTML}{000000}
    \definecolor{bkg}{HTML}{FFFFFF}
    \definecolor{blk}{HTML}{CCD3D8}
}{\relax}

% hfut
\ifdefstring{\SIMPLE@theme}{hfut}{
    \definecolor{pri}{HTML}{A52828}
    \definecolor{sec}{HTML}{63071C}
    \definecolor{ter}{HTML}{2E3840}
    \definecolor{ale}{HTML}{63071C}
    \definecolor{txt}{HTML}{000000}
    \definecolor{bkg}{HTML}{FFFFFF}
    \definecolor{blk}{HTML}{F4EEE0}
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

\setbeamercolor{normal text}{fg=txt}
\setbeamercolor{background canvas}{bg=bkg}
\setbeamercolor{block body}{bg=blk!30,fg=txt!90}
\setbeamercolor{block title}{bg=blk,fg=txt!90}

% blocks 圆角
\setbeamertemplate{blocks}[rounded][shadow=false]

% 设置链接格式
\hypersetup{
    pdfborder={0 0 0},
    colorlinks=true,
    linkcolor={pri!60!black},
    urlcolor={sec},
    filecolor={ter},
    citecolor={blk},
    linktoc=all
}

% 目录显示次级标题
\def\beamer@tableofcontents[#1]{%
    \def\beamer@toc@cs{show}%
    \def\beamer@toc@os{show}%
    \def\beamer@toc@css{show}%
    \def\beamer@toc@oss{show}%
    \def\beamer@toc@ooss{show}%
    \def\beamer@toc@csss{show}%
    \def\beamer@toc@osss{show}%
    \def\beamer@toc@oosss{show}%
    \def\beamer@toc@ooosss{show}%
    \beamer@showpartnumber=\c@part%
    \beamer@pausesectionsfalse%
    \beamer@pausesubsectionsfalse%
    \def\beamer@tocsections{<*>}%
    \setkeys{beamertoc}{firstsection=1}%
    \setkeys{beamertoc}{#1}%
    % \vspace*{-.5em}
    {\makeatletter%
        \pause[0]%
        \@input{\jobname.toc}%
        \vfill}%
}

% 主标题显示序号，字体大小设为footnotesize
\setbeamertemplate{section in toc}[sections numbered]
\setbeamerfont{subsection in toc}{size=\footnotesize}
% 定理等环境显示序号
\setbeamertemplate{theorems}[numbered]

% 定理等环境宽度设置为.9行宽
\setbeamertemplate{theorem begin}{%
    \begin{center}
        \begin{minipage}{.9\textwidth}
            \centering
            \begin{\inserttheoremblockenv}
                {%
                    \inserttheoremname
                    \inserttheoremnumber
                    \ifx\inserttheoremaddition\@empty\else\ (\inserttheoremaddition)\fi%
                }%
                }
                \setbeamertemplate{theorem end}{%
            \end{\inserttheoremblockenv}
        \end{minipage}
    \end{center}
}

% 首行不缩进
\setlength\parindent{0pt}
% 调整item缩进
\settowidth{\leftmargini}{\usebeamertemplate{itemize item}}
\addtolength{\leftmargini}{2\labelsep}
% 设置参考文献字体大小
\setbeamerfont{bibliography item}{size=\tiny}
\setbeamerfont{bibliography entry author}{size=\tiny}
\setbeamerfont{bibliography entry title}{size=\tiny}
\setbeamerfont{bibliography entry location}{size=\tiny}
\setbeamerfont{bibliography entry note}{size=\tiny}


\RequirePackage{tikz-3dplot}
\RequirePackage{tikzscale}
\RequirePackage{csvsimple}
\RequirePackage{pgfplots}
\usepgfplotslibrary{groupplots}
\usepgfplotslibrary{patchplots}
\usetikzlibrary{arrows.meta,angles,quotes,calc}
\pgfplotsset{compat=newest}
\pgfplotsset{
    layers/my layer set/.define layer set={
            background,
            main,
            foreground
        }{},
    set layers=my layer set,
}
\usetikzlibrary{matrix,calc}

\definecolor{c1}{rgb}{0, 0.4470, 0.7410}  % blue
\definecolor{c2}{rgb}{0.8500, 0.3250, 0.0980} % red
\definecolor{c3}{rgb}{0.9290, 0.6940, 0.1250} % yellow
\definecolor{c4}{rgb}{0.4940, 0.1840, 0.5560} % purple
\definecolor{c5}{rgb}{0.4660, 0.6740, 0.1880} % green
\definecolor{c6}{rgb}{0.3010, 0.7450, 0.9330} % cyan
\definecolor{c7}{rgb}{0.6350, 0.0780, 0.1840} % dark red
\definecolor{c8}{RGB}{99,200,166}
\definecolor{c9}{RGB}{72,107,135}
\definecolor{c10}{RGB}{248,148,125}

\pgfplotsset{
    colormap={matlab}{
            color(0cm)=(c1)
            color(1cm)=(c2)
            color(2cm)=(c3)
            color(3cm)=(c4)
            color(4cm)=(c5)
            color(5cm)=(c6)
            color(6cm)=(c7)
        },
}
