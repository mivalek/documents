"use strict";

var args = process.argv.slice(2);
const puppeteer = require("puppeteer");
(async () => {
    const browser = await puppeteer.launch();
    const page = await browser.newPage();
    await page.goto("file://" + args[0] + "/temp.html");
    await page.pdf({
        path: "test.pdf",
        format: "A4",
        margin: {
            top: "20px",
            left: "20px",
            right: "20px",
            bottom: "20px",
        },
    });
    await browser.close();
})();
