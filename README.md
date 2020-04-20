## How to edit the MRSHub website (MRSHub.org)

The MRSHub website is generated from simple text files, using the popular static site generator website Jekyll. It is built and served through the free service Netlify. The text files that the site is built from live in a GitHub repository (https://github.com/mrshub/mrshub-website).

To maintain and update the MRSHub website, you will need to set up two software packages on your computer:
- **Jekyll** to test changes locally before committing them to the GitHub repository where the website text files live. Follow the [Jekyll installation guide](https://jekyllrb.com/docs/installation/) to set up Jekyll.
- **Git** (and optionally the GitHub Desktop software) to track and commit changes you make in your local copy to the website repository.

1. Clone the 'develop' branch to a folder of your choice on your computer.

2. Make changes to files as you see fit.

3. To test the changes you made locally, open a terminal or prompt, navigate to the folder you just created (so you can see the file `_config.yml`).

4. Type the command `jekyll serve` and hit Enter.

5. After a while, you should see a line `Server address: http://127.0.0.1:4000/`. You can copy the address into your web browser and test the functionality of the local copy of the site. In the terminal window, hitting Ctrl-C will stop the Jekyll server.
