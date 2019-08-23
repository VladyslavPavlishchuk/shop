Encore
// ...
.autoProvidejQuery()
.autoProvideVariables({
     $: 'jquery',
     jQuery: 'jquery',
     'window.jQuery': 'jquery',
})
;

const webpack = require('webpack');
const path = require('path');
const autoprefixer = require('autoprefixer');
const precss = require('precss');
const TransferWebpackPlugin = require('transfer-webpack-plugin');
const ExtractTextPlugin = require('extract-text-webpack-plugin');

module.exports = {
    devtool: 'eval',
    entry: [
        'webpack/hot/only-dev-server',
        'tether',
        './client/app.jsx'
    ],
    output: {
        path: path.resolve(__dirname, 'build'),
        filename: 'bundle.js'
    },
    devServer: {
        contentBase: 'build/', // Relative directory for base of server
        publicPath: '/', // Live-reload
        inline: true,
        port: process.env.PORT || 3000, // Port Number
        host: 'localhost', // Change to '0.0.0.0' for external facing server
        historyApiFallback: true,
    },
    plugins: [
        new webpack.HotModuleReplacementPlugin(),
        new ExtractTextPlugin('main.css'),
        new TransferWebpackPlugin([
            { from: 'client' },
        ])
    ],
    module: {
        rules: [
            {
                test: /\.jsx?$/,
                exclude: /node_modules/,
                loader: 'babel-loader',
                query: {
                    cacheDirectory: true,
                },
            },
            {
                test: /\.woff2?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
                use: 'url-loader?limit=10000',
            },
            {
                test: /\.(ttf|eot|svg)(\?[\s\S]+)?$/,
                use: 'file-loader',
            },
            {
                test: /\.(jpe?g|png|gif|svg)$/i,
                use: [
                    'file-loader?name=images/[name].[ext]',
                    'image-webpack-loader?bypassOnDebug'
                ]
            }
        ]
    }
};