import "./App.css";

function App() {
  return (
    <>
      <div className="flex h-screen w-screen">
        <div className="w-4/6 text-left m-auto ">
          <div className="flex items-center justify-center lg:justify-start gap-2 mb-10">
            <span className="w-20 h-0.5 bg-indigo-700"></span>
            <p className="font-medium text-indigo-700 text-xl">Nate Cheng</p>
          </div>
          <h1 className="font-bold text-gray-800 text-xl md:text-2xl xl:text-3xl mb-10">
            Simple github action demo for a Pull Request web link
          </h1>
          <p className="font-normal text-gray-500 text-sm md:text-md xl:text-lg mb-10">
            This is an article serves as a comprehensive guide, illustrating
            each step involved in crafting a GitHub action for deploying your
            pull request code to a web service hosted on a concise sub-domain,
            and subsequently sharing the pull request link within the PR
            comments.
          </p>
          <a
            href="https://medium.com/p/406d05eac99c"
            className="flex items-center justify-center xl:justify-start gap-3 font-medium text-indigo-800 text-md hover:text-indigo-600 transition ease-in-out duration-300"
          >
            See the Medium article
            <svg
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
              strokeWidth={1.5}
              stroke="currentColor"
              className="w-6 h-6"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                d="M13.5 4.5L21 12m0 0l-7.5 7.5M21 12H3"
              />
            </svg>
          </a>
          <a
            href="https://github.com/nch3ng/github-actions-pr-link-demo"
            className="flex items-center justify-center xl:justify-start gap-3 font-medium text-indigo-800 text-md hover:text-indigo-600 transition ease-in-out duration-300"
          >
            See the source code with a Pull Request
            <svg
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
              strokeWidth={1.5}
              stroke="currentColor"
              className="w-6 h-6"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                d="M13.5 4.5L21 12m0 0l-7.5 7.5M21 12H3"
              />
            </svg>
          </a>
          <a
            href="https://medium.com/p/406d05eac99c"
            className="flex items-center justify-center xl:justify-start gap-3 font-medium text-indigo-800 text-md hover:text-indigo-600 transition ease-in-out duration-300"
          >
            See the PR-link
            <svg
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
              strokeWidth={1.5}
              stroke="currentColor"
              className="w-6 h-6"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                d="M13.5 4.5L21 12m0 0l-7.5 7.5M21 12H3"
              />
            </svg>
          </a>
        </div>
      </div>
      <a href="https://pr-2.pr-demo.natecheng.com">
        <img
          decoding="async"
          width="149"
          height="149"
          src="https://github.blog/wp-content/uploads/2008/12/forkme_right_darkblue_121621.png?resize=149%2C149"
          className="attachment-full size-full top-right"
          alt="Fork me on GitHub"
          loading="lazy"
          data-recalc-dims="1"
        />
      </a>
    </>
  );
}

export default App;
