import "./App.css";

function App() {
  return (
    <>
      <div className="flex h-screen w-screen">
        <div>This is a PR link page</div>
        <div className="m-auto">You can follow on here: </div>
      </div>
      <a href="https://github.com/you">
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
