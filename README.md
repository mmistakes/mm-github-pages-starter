## How to edit the MRSHub website (MRSHub.org)

The [MRSHub website](https://www.mrshub.org) is generated from simple text files, using the popular static site generator website [Jekyll](https://jekyllrb.com/). It is built and served through the free service [Netlify](https://www.netlify.com/).

The text files that the site is built from live in the 'master' branch of a [GitHub repository](https://github.com/mrshub/mrshub-website/tree/master) of the MRSHub account. Whenever the files in this repository are changed, Netlify compiles the Jekyll files and rebuilds the website automatically.

To maintain and update the MRSHub website, you will need to set up two software packages on your computer:
- **Jekyll** to test changes locally before committing them to the GitHub repository where the website text files live. Follow the [Jekyll installation guide](https://jekyllrb.com/docs/installation/) to set up Jekyll.
- **Git** (and optionally the GitHub Desktop software) to track and commit changes you make in your local copy to the website repository.

## MRSHub website maintenance workflow

1. Clone the ['develop' branch of the website GitHub repository](https://github.com/mrshub/mrshub-website/tree/develop) into a folder of your choice on your computer.

2. Make changes to files as you see fit. The MRSHub website is built around the widely used and well-supported [Minimal Mistakes theme](https://mmistakes.github.io/minimal-mistakes/docs/quick-start-guide/).

3. To test the changes you made locally, open a terminal or prompt, navigate to the folder you just created (so you can see the file `_config.yml`).

4. Type the command `jekyll serve` and hit Enter.

5. After a while, you should see a line `Server address: http://127.0.0.1:4000/`. You can copy the address into your web browser and test the functionality of the local copy of the site. Make sure that all the changes you made appear. Back in the terminal window, hitting Ctrl-C will stop the local Jekyll server.

6. If you're happy with the local rendering of the site, commit the changes back to the 'develop' branch of the repository.

7. Submit a pull request from the 'develop' branch to the 'master' branch of the repository. The site will then automatically be rebuilt by the Netlify host service. You can check the status of the rebuild by logging into Netlify with the MRSHub GitHub account credentials. Once the build is successful, the [MRSHub website](https://www.mrshub.org) is live without further ado.
